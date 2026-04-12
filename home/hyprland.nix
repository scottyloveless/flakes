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
                gaps_out = 10;
                border_size = 2;
              };

            env = [
              "WLR_DRM_NO_ATOMIC,1"
              "WLR_RENDERER_ALLOW_SOFTWARE,1"
              "__GLX_VENDOR_LIBRARY_NAME,mesa"
              "LIBGL_ALWAYS_SOFTWARE,1"
            ];
          };
      };
  }
