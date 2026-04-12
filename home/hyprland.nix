{ ... }:
{
    wayland.windowManager.hyprland = {
        enable = true;
        settings = {
            monitor = ",preferred,auto,2";
            "$terminal" = "ghostty";
            "$mod" = "SUPER";
            "$browser" = "firefox";

            bind = [
              "$mod, RETURN, exec, $terminal"
              "$mod, Q, killactive,"
              "$mod, M, exit,"
              "$mod, H, movefocus, l"
              "$mod, L, movefocus, r"
              "$mod, K, movefocus, u"
              "$mod, J, movefocus, d"
              "$mod, B, exec, $browser"
            ];

            general = {
                gaps_in = 5;
                gaps_out = 20;
                border_size = 2;
                
                col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg;
                col.inactive_border = rgba(595959aa);

                resize_on_border = false;

                allow_tearing = false;

                layout = "dwindle";

              };

            decoartion = {

              rounding = 10;
              rounding_power = 2;

              # Change transparency of focused and unfocused windows
              active_opacity = 1.0;
              inactive_opacity = 1.0;

              shadow = {
                  enabled = true;
                  range = 4;
                  render_power = 3;
                  color = rgba(1a1a1aee);
              };

              # https://wiki.hypr.land/Configuring/Variables/#blur
              blur = {
                  enabled = false;
                  size = 3;
                  passes = 1;

                  vibrancy = 0.1696;
              };
            };

            env = [
              "WLR_DRM_NO_ATOMIC,1"
              "WLR_RENDERER_ALLOW_SOFTWARE,1"
              "__GLX_VENDOR_LIBRARY_NAME,mesa"
              "LIBGL_ALWAYS_SOFTWARE,1"

              "XCURSOR_SIZE,24"
              "HYPRCURSOR_SIZE,24"
            ];
          };
      };
  }
