{ ... }:
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 32;
        spacing = 6;
        margin-top = 6;
        margin-left = 8;
        margin-right = 8;

        modules-left = [
          "hyprland/workspaces"
          "niri/workspaces"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "cpu"
          "memory"
          "pulseaudio"
          "network"
          "battery"
          "tray"
        ];

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          format = "{id}";
          persistent-workspaces."*" = 5;
        };

        "niri/workspaces" = {
          format = "{value}";
          format-icons = {
            active = "●";
            default = "○";
            empty = "·";
          };
        };

        "hyprland/window" = {
          format = "{title}";
          max-length = 50;
          separate-outputs = true;
        };

        clock = {
          format = "󰥔 {:%H:%M}";
          format-alt = "󰃭 {:%Y-%m-%d %H:%M}";
          tooltip-format = "<tt>{calendar}</tt>";
        };

        cpu = {
          interval = 5;
          format = "󰍛 {usage}%";
          tooltip = true;
        };

        memory = {
          interval = 5;
          format = "󰾆 {percentage}%";
          tooltip-format = "{used:0.1f}G / {total:0.1f}G";
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "󰝟 muted";
          format-icons = {
            default = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
            headphone = "󰋋";
            headset = "󰋎";
          };
          on-click = "pavucontrol";
        };

        network = {
          format-wifi = "󰖩 {signalStrength}%";
          format-ethernet = "󰈀";
          format-disconnected = "󰖪";
          tooltip-format = "{essid} | {ipaddr}";
        };

        battery = {
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-full = "󰁹";
          format-icons = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          states = {
            warning = 30;
            critical = 15;
          };
        };

        tray = {
          icon-size = 14;
          spacing = 6;
        };
      };
    };

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 14px;
        font-weight: 1000;
        min-height: 0;
      }

      /* Transparent bar — pills will have their own background */
      window#waybar {
        background: transparent;
        color: #c0caf5;
      }

      /* Shared pill styling */
      #workspaces,
      #window,
      #clock,
      #cpu,
      #memory,
      #pulseaudio,
      #network,
      #battery,
      #tray {
        background: rgba(26, 27, 38, 0.85);
        border-radius: 12px;
        padding: 0 12px;
        margin: 4px 2px;
      }

      /* Workspaces pill */
      #workspaces {
        padding: 0 4px;
      }

      #workspaces button {
        padding: 0 8px;
        color: #565f89;
        background: transparent;
        border: none;
        border-radius: 10px;
      }

      #workspaces button.active {
        color: #7aa2f7;
        background: rgba(122, 162, 247, 0.15);
      }

      #workspaces button:hover {
        color: #7dcfff;
        background: rgba(125, 207, 255, 0.1);
      }

      /* Per-module colors */
      #window     { color: #a9b1d6; }
      #clock      { color: #bb9af7; }
      #cpu        { color: #9ece6a; }
      #memory     { color: #7dcfff; }
      #pulseaudio { color: #e0af68; }
      #network    { color: #9ece6a; }
      #battery    { color: #7dcfff; }

      #battery.warning  { color: #ff9e64; }
      #battery.critical { color: #f7768e; }
      #battery.charging { color: #9ece6a; }

      /* Tooltips */
      tooltip {
        background: #16161e;
        border: 1px solid #414868;
        border-radius: 6px;
      }

      tooltip label {
        color: #c0caf5;
        padding: 4px;
      }
    '';
  };
}
