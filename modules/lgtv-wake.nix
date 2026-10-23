# Wake an LG webOS TV (Wake-on-LAN) and switch it to the PC's HDMI input whenever a
# DualSense / DualSense Edge connects, unless the HDMI port is plugged into a monitor
# listed in skipIfConnectedTo.
#
# TV setup: give it a DHCP reservation, and enable
#   Settings > General > Devices > External Devices > TV On With Mobile > Turn on via Wi-Fi
# (the name says Wi-Fi, but it covers wired LAN too).
#
# One-time pairing (the key can't be declarative), with the TV ON:
#   sudo lgtv-wake pair      -> accept the prompt on the TV
# The key is stored in /var/lib/lgtv-wake/client-key.
{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.services.lgtv-wake;

  wakeScript =
    pkgs.writers.writePython3Bin "lgtv-wake"
      {
        libraries = [ pkgs.python3Packages.aiowebostv ];
        flakeIgnore = [ "E501" ];
      }
      (
        builtins.replaceStrings
          [ "@config@" ]
          [
            (builtins.toJSON {
              inherit (cfg)
                host
                mac
                broadcast
                input
                timeout
                settleSeconds
                skipIfConnectedTo
                ;
              stateDir = "/var/lib/lgtv-wake";
            })
          ]
          (builtins.readFile ./lgtv-wake.py)
      );
in
{
  options.services.lgtv-wake = {
    enable = lib.mkEnableOption "waking an LG TV when a DualSense controller connects";

    host = lib.mkOption {
      type = lib.types.str;
      example = "192.168.1.50";
      description = "IP address or hostname of the TV.";
    };

    mac = lib.mkOption {
      type = lib.types.str;
      example = "a1:b2:c3:d4:e5:f6";
      description = "MAC address of the TV's network interface (the one it's connected with).";
    };

    broadcast = lib.mkOption {
      type = lib.types.str;
      default = "255.255.255.255";
      description = "Broadcast address for the Wake-on-LAN packet.";
    };

    input = lib.mkOption {
      type = lib.types.str;
      default = "HDMI_1";
      description = "webOS input ID to switch to.";
    };

    timeout = lib.mkOption {
      type = lib.types.ints.positive;
      default = 45;
      description = "Seconds to keep trying to reach the TV while it boots.";
    };

    settleSeconds = lib.mkOption {
      type = lib.types.ints.unsigned;
      default = 3;
      description = "Delay before re-sending the input switch as a safety net.";
    };

    skipIfConnectedTo = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      example = [ "AW3225QF" ];
      description = ''
        Do nothing if a connected HDMI connector's EDID contains any of these strings
        (the monitor name, as shown in hyprland's `desc:`).
      '';
    };

    bluetoothOnly = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Only trigger on Bluetooth connections, not when plugging the controller in over USB to charge.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ wakeScript ];

    # js* matches only the gamepad node, so this fires once per connection (not again for the
    # touchpad and motion-sensor nodes the controller also creates).
    services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="input", KERNEL=="js*", ATTRS{name}=="*DualSense*"${lib.optionalString cfg.bluetoothOnly '', ATTRS{id/bustype}=="0005"''}, TAG+="systemd", ENV{SYSTEMD_WANTS}+="lgtv-wake.service"
    '';

    systemd.services.lgtv-wake = {
      description = "Wake LG TV and switch to ${cfg.input} when a DualSense connects";
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = lib.getExe wakeScript;
        TimeoutStartSec = cfg.timeout + cfg.settleSeconds + 15;
        StateDirectory = "lgtv-wake";
        StateDirectoryMode = "0700";
      };
    };
  };
}
