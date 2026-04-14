{ ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        position = "top";
        height = 31;
        modules-left = [ "hyprland/workspaces" ];
        modules-right = [
          # "temperature"
          # "disk"
          "memory"
          "cpu"
          # "tray"
          "network"
          "pulseaudio"
          "battery"
          "custom/date"
          "clock"
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
          format-icons = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
            "10" = "10";
          };
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
          format = "{:%H:%M}";
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

        temperature = {
          hwmon-path = "/sys/class/hwmon/hwmon4/temp1_input";
          format = "CPU {temperatureC}°C ";
        };

        network = {
          format-wifi = "{essid}";
          format-ethernet = "ETH-IP: {ipaddr}";
          format-linked = "{ifname} (No IP)";
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
              ""
              ""
            ];
          };
        };

        tray = {
          icon-size = 13;
          spacing = 5;
        };

        disk = {
          interval = 30;
          format = "ROOT {percentage_free}% FREE";
          path = "/";
        };

        memory = {
          interval = 30;
          format = "RAM {used:0.1f}G/{total:0.1f}G ";
        };

        cpu = {
          interval = 10;
          format = "CPU {}% ";
          max-length = 20;
        };
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: JetBrainsMono Nerd Font;
        font-size: 12px;
        min-height: 0;
      }

      window#waybar {
        background: #12131a;
        color: white;
      }

      #workspaces {
        background-color: #1d202e;
        margin: 5px;
        margin-left: 6px;
        border-radius: 5px;
      }

      #workspaces button {
        padding: 2px 8px;
        color: #fff;
      }

      #workspaces button.focused {
        color: #24283b;
        background-color: #7aa2f7;
        border-radius: 5px;
      }

      #workspaces button:hover {
        background-color: #7dcfff;
        color: #24283b;
        border-radius: 5px;
      }

      #custom-date,
      #clock,
      #battery,
      #pulseaudio,
      #network {
        background-color: #1d202e;
        padding: 2px 10px;
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
        padding: 3px 10px;
      }

      #clock {
        color: #b48ead;
        border-radius: 0px 5px 5px 0px;
        margin-right: 6px;
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

      #temperature {
        background-color: #24283b;
        margin: 5px 0;
        padding: 0 10px;
        border-top-left-radius: 5px;
        border-bottom-left-radius: 5px;
        color: #82e4ff;
      }

      #disk {
        color: #b9f27c;
        margin: 5px 0;
        padding-right: 10px;
        background-color: #24283b;
        border-top-right-radius: 5px;
        border-bottom-right-radius: 5px;
        margin-right: 3px;
      }

      #memory {
        margin-left: 5px;
        background: #2a3152;
        margin: 5px 0;
        padding: 0 10px;
        margin-left: 3px;
        border-top-left-radius: 5px;
        border-bottom-left-radius: 5px;
        color: #ff9e64;
      }

      #cpu {
        margin: 5px 0;
        padding: 0 10px;
        background-color: #2a3152;
        color: #ff7a93;
        border-top-right-radius: 5px;
        border-bottom-right-radius: 5px;
        margin-right: 6px;
      }

      #tray {
        background-color: #455085;
        margin: 5px;
        margin-left: 0px;
        margin-right: 6px;
        border-radius: 5px;
        padding: 0 10px;
      }

      #tray > * {
        padding: 0 2px;
        margin: 0 2px;
      }
    '';
  };
}
