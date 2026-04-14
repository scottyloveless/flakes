{ ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        position = "top";
        height = 30;
        modules-left = [ "hyprland/workspaces" ];
        modules-right = [
          "network"
          "pulseaudio"
          "battery"
          "custom/date"
          "clock"
          "custom/power"
        ];

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          format = "{icon}";
          persistent-workspaces = {
            "1" = [ ];
            "2" = [ ];
            "3" = [ ];
            "4" = [ ];
            "5" = [ ];
            "6" = [ ];
            "7" = [ ];
            "8" = [ ];
            "9" = [ ];
            "10" = [ ];
          };
          # format-icons = {
          #   "1" = "󰋜";
          #   "2" = "󰖟";
          #   "3" = "󰠮";
          #   "4" = "󰭹";
          #   "5" = "󱓷";
          #   "6" = "󱇧";
          #   "7" = "󰊢";
          #   "8" = "󰖲";
          #   "9" = "󰕧";
          #   "10" = "󰝚";
          # };
        };

        "custom/date" = {
          format = "󰸗 {}";
          interval = 3600;
          exec = "$HOME/bin/waybar-date.sh";
        };

        "custom/power" = {
          format = "󰐥";
          on-click = "$HOME/bin/waybar-power.sh";
        };

        clock = {
          format = "󰅐 {:%H:%M}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󰂄{capacity}%";
          format-alt = "{time} {icon}";
          format-full = "󱈑 {capacity}%";
          format-icons = [
            "󱊡"
            "󱊢"
            "󱊣"
          ];
        };

        network = {
          format-wifi = "  {essid}";
          format-ethernet = "{ifname}: {ipaddr}/{cidr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "󰤮 Disconnected";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
        };

        pulseaudio = {
          format = "{icon}  {volume}%";
          format-muted = "󰖁 Muted";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
              ""
            ];
          };
        };
      };
    };

    style = ''
            * {
              border: none;
              border-radius: 0;
              font-family: mononoki Nerd Font;
              font-size: 14px;
              min-height: 0;
            }

            window#waybar {
              background: transparent;
              color: white;
            }
          
      #workspaces {
        background-color: transparent;
        margin: 3px;
        margin-left: 10px;
      }

      #workspaces button {
        all: unset;
        padding: 0;
        min-width: 24px;
        min-height: 24px;
        margin: 3px 2px;
        color: #c0caf5;
        background-color: #24283b;
        border-radius: 50%;
        align-items: center;
        justify-content: center;
      }

      #workspaces button.active {
        color: #24283b;
        background-color: #7aa2f7;
        border-radius: 50%;
      }

      #workspaces button:hover {
        background-color: #7dcfff;
        color: #24283b;
        border-radius: 50%;
      }

      #workspaces button label {
        margin: 0;
        padding: 0;
      }

            #custom-date,
            #clock,
            #battery,
            #pulseaudio,
            #network {
              background-color: #24283b;
              padding: 5px 10px;
              margin: 5px 0px;
            }

            #custom-date {
              color: #7dcfff;
            }

            #custom-power {
              color: #24283b;
              background-color: #db4b4b;
              border-radius: 5px;
              margin-right: 10px;
              margin-top: 5px;
              margin-bottom: 5px;
              margin-left: 0px;
              padding: 5px 10px;
            }

            #clock {
              color: #b48ead;
              border-radius: 0px 5px 5px 0px;
              margin-right: 10px;
            }

            #battery {
              color: #9ece6a;
            }

            #battery.charging {
              color: #9ece6a;
            }

            #battery.warning:not(.charging) {
              background-color: #f7768e;
              color: #24283b;
              border-radius: 5px 5px 5px 5px;
            }

            #network {
              color: #f7768e;
              border-radius: 5px 0px 0px 5px;
            }

            #pulseaudio {
              color: #e0af68;
            }
    '';
  };
}
