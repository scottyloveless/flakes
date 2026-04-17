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
        spacing = 4;
        margin = "0 0 0 0";

        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
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
          format = "{:%H:%M}";
          format-alt = "{:%Y-%m-%d %H:%M}";
          tooltip-format = "<tt>{calendar}</tt>";
        };

        cpu = {
          interval = 5;
          format = "cpu {usage}%";
          tooltip = true;
        };

        memory = {
          interval = 5;
          format = "ram {percentage}%";
          tooltip-format = "{used:0.1f}G / {total:0.1f}G";
        };

        pulseaudio = {
          format = "vol {volume}%";
          format-muted = "vol mute";
          on-click = "pavucontrol";
        };

        network = {
          format-wifi = "wifi {signalStrength}%";
          format-ethernet = "eth";
          format-disconnected = "off";
          tooltip-format = "{essid} | {ipaddr}";
        };

        battery = {
          format = "bat {capacity}%";
          format-charging = "chr {capacity}%";
          format-full = "full";
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
              font-size: 13px;
              font-weight: 700;
              min-height: 0;
            }

            window#waybar {
              background: rgba(26, 27, 38, 0.85);
              color: #c0caf5;
              border: 0px solid #414868;
              border-radius: 0px;
            }

            #workspaces {
              padding: 0 4px;
            }

            #workspaces button {
              padding: 0 8px;
              color: #565f89;
              background: transparent;
              border: none;
            }

            #workspaces button.active {
              color: #7aa2f7;
            }

            #workspaces button:hover {
              color: #7dcfff;
              background: transparent;
            }

            #window {
              color: #a9b1d6;
              padding: 0 10px;
            }

            #clock {
              color: #bb9af7;
              padding: 0 10px;
            }

            #pulseaudio,
            #network,
            #battery {
              color: #c0caf5;
              padding: 0 8px;
            }

            #pulseaudio { color: #e0af68; }
            #network    { color: #9ece6a; }
            #battery    { color: #7dcfff; }

            #battery.warning  { color: #ff9e64; }
            #battery.critical { color: #f7768e; }
            #battery.charging { color: #9ece6a; }

            #tray {
              padding: 0 8px;
            }

            tooltip {
              background: #16161e;
              border: 1px solid #414868;
              border-radius: 4px;
            }

            tooltip label {
              color: #c0caf5;
              padding: 4px;
            }

      #cpu,
      #memory {
        color: #c0caf5;
        padding: 0 8px;
      }

      #cpu {
        color: #9ece6a;
      }

      #memory {
        color: #7dcfff;
      }
    '';
  };
}
