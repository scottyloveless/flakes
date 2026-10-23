"""Wake an LG webOS TV and switch it to the PC's HDMI input.

  lgtv-wake         wake the TV (Wake-on-LAN) and switch input
  lgtv-wake pair    one-time: pair with the TV (it must be on) and store the key
"""

import asyncio
import glob
import json
import os
import socket
import sys
import time

from aiowebostv import WebOsClient, WebOsTvPairError

CONFIG = json.loads(r"""@config@""")
KEY_FILE = os.path.join(CONFIG["stateDir"], "client-key")


def log(msg):
    print(msg, flush=True)


def hdmi_sink_to_skip():
    """Return the first skip pattern found in a connected HDMI sink's EDID."""
    for conn in sorted(glob.glob("/sys/class/drm/card*-HDMI-A-*")):
        try:
            with open(os.path.join(conn, "status")) as f:
                if f.read().strip() != "connected":
                    continue
            with open(os.path.join(conn, "edid"), "rb") as f:
                edid = f.read()
        except OSError:
            continue
        for pattern in CONFIG["skipIfConnectedTo"]:
            if pattern.encode() in edid:
                return f"{pattern} on {os.path.basename(conn)}"
    return None


def send_wol():
    mac = bytes.fromhex(CONFIG["mac"].replace(":", "").replace("-", ""))
    packet = b"\xff" * 6 + mac * 16
    with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as s:
        s.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
        s.sendto(packet, (CONFIG["broadcast"], 9))


async def connect(key, deadline):
    """Keep trying to reach the TV's websocket API until the deadline."""
    attempt = 0
    while time.monotonic() < deadline:
        attempt += 1
        # The first packet can land while the NIC is still napping; resend.
        if attempt % 5 == 1:
            send_wol()
        client = WebOsClient(CONFIG["host"], key)
        try:
            await asyncio.wait_for(client.connect(), timeout=5)
            return client
        except WebOsTvPairError:
            raise
        except Exception:
            await client.disconnect()
            await asyncio.sleep(1)
    return None


async def pair():
    log(f"Pairing with {CONFIG['host']}: accept the prompt on the TV...")
    client = WebOsClient(CONFIG["host"])
    await asyncio.wait_for(client.connect(), timeout=60)
    os.makedirs(CONFIG["stateDir"], exist_ok=True)
    fd = os.open(KEY_FILE, os.O_WRONLY | os.O_CREAT | os.O_TRUNC, 0o600)
    with os.fdopen(fd, "w") as f:
        f.write(client.client_key)
    await client.disconnect()
    log(f"Paired; key saved to {KEY_FILE}")


async def wake():
    skip = hdmi_sink_to_skip()
    if skip:
        log(f"HDMI goes to {skip}, not the TV; leaving the TV alone.")
        return 0

    try:
        with open(KEY_FILE) as f:
            key = f.read().strip()
    except OSError:
        log(f"No client key in {KEY_FILE}; run `sudo lgtv-wake pair` first.")
        return 1

    log(f"Waking {CONFIG['host']} and switching to {CONFIG['input']}...")
    deadline = time.monotonic() + CONFIG["timeout"]
    client = await connect(key, deadline)
    if client is None:
        log("TV never answered. Is 'Turn on via Wi-Fi' enabled on the TV?")
        return 1

    try:
        await client.set_input(CONFIG["input"])
        # webOS can accept commands while the panel is still coming up and
        # drop them; resend once after it settles.
        await asyncio.sleep(CONFIG["settleSeconds"])
        await client.set_input(CONFIG["input"])
    finally:
        await client.disconnect()
    log("Done.")
    return 0


def main():
    if sys.argv[1:] == ["pair"]:
        asyncio.run(pair())
        return 0
    if sys.argv[1:]:
        print(__doc__, file=sys.stderr)
        return 2
    return asyncio.run(wake())


if __name__ == "__main__":
    sys.exit(main())
