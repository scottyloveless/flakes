# modules/nixos/lgtv-wake.nix
#
# Wake an LG webOS TV (Wake-on-LAN) and switch it to the PC's HDMI input
# whenever a DualSense / DualSense Edge connects (Bluetooth or USB).
#
# One-time imperative step (pairing key can't be declarative):
#   with the TV ON:  alga setup <tv-ip>   -> accept the prompt on the TV
#   writes host, client key and MAC to ~/.config/alga/config.json
{ config, lib, pkgs, inputs, ... }:

let
  cfg = config.services.lgtv-wake;

  wakeScript = pkgs.writeShellApplication {
    name = "lgtv-wake";
    runtimeInputs = [ cfg.package pkgs.coreutils pkgs.gnugrep ];
    text = ''
      ${lib.optionalString cfg.requireHdmiConnected ''
        if ! grep -qsx connected /sys/class/drm/card*-HDMI-A-*/status; then
          echo "No HDMI connector reports 'connected'; skipping."
          exit 0
        fi
      ''}

      echo "Sending Wake-on-LAN to TV..."
      alga power on || true   # harmless if the TV is already on

      for attempt in $(seq 1 ${toString cfg.retries}); do
        if alga input set ${lib.escapeShellArg cfg.input} >/dev/null 2>&1; then
          echo "Switched to ${cfg.input} on attempt $attempt."
          # webOS sometimes accepts commands while still booting the panel
          # and drops them; resend once after it has settled.
          sleep ${toString cfg.settleSeconds}
          alga input set ${lib.escapeShellArg cfg.input} >/dev/null 2>&1 || true
          exit 0
        fi
        sleep 1
      done

      echo "TV never answered. On wall power? Quick Start+ and 'Turn on via Wi-Fi' enabled?" >&2
      exit 1
    '';
  };
in
{
  options.services.lgtv-wake = {
    enable = lib.mkEnableOption "waking an LG TV when a DualSense controller connects";

    package = lib.mkOption {
      type = lib.types.package;
      default = inputs.alga.packages.${pkgs.stdenv.hostPlatform.system}.default;
      defaultText = lib.literalExpression "inputs.alga.packages.\${system}.default";
      description = "The alga package (LG webOS CLI).";
    };

    input = lib.mkOption {
      type = lib.types.str;
      default = "HDMI_1";
      description = "webOS input ID to switch to.";
    };

    retries = lib.mkOption {
      type = lib.types.ints.positive;
      default = 25;
      description = "Seconds to keep retrying the input switch while the TV boots.";
    };

    settleSeconds = lib.mkOption {
      type = lib.types.ints.unsigned;
      default = 3;
      description = "Delay before re-sending the input switch as a safety net.";
    };

    requireHdmiConnected = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Only act if a DRM HDMI connector reports "connected". Test first:
        some TVs drop hot-plug detect in standby, which would make this
        always skip.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];

    # Match only the gamepad event node (not the motion-sensor/touchpad nodes),
    # then ask the logged-in user's systemd to start the service.
    services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="input", KERNEL=="event*", ENV{ID_INPUT_JOYSTICK}=="1", ATTRS{name}=="*DualSense*", TAG+="systemd", ENV{SYSTEMD_USER_WANTS}+="lgtv-wake.service"
    '';

    systemd.user.services.lgtv-wake = {
      description = "Wake LG TV and switch to ${cfg.input} when a DualSense connects";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = lib.getExe wakeScript;
        TimeoutStartSec = cfg.retries + cfg.settleSeconds + 15;
      };
    };
  };
}
