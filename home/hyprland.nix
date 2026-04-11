{ ... }:
{
    wayland.windowManager.hyprland = {
        enable = true;
        settings = {
            monitor = ",preferred,auto,2";
            "$terminal" = "ghostty";
            "$mod" = "SUPER";

            bind = [
              "$mod, Return, exec, $terminal"
              "$mod, Q, killactive,"
              "$mod, M, exit,"
              "$mod, H, movefocus, l"
              "$mod, L, movefocus, r"
              "$mod, K, movefocus, u"
              "$mod, J, movefocus, d"
            ];

            general = {
                gaps_in = 5;
                gaps_out = 10;
                border_size = 2;
              };
          };
      };
  }
