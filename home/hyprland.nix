{ pkgs, ... }:
{
  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "~/wallpapers/dopamine.png"
      ];
      wallpaper = [
        {
          monitor = "";
          path = "~/wallpapers/dopamine.png";
        }
      ];
      splash = false;
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    settings = {
      monitor = ",preferred,auto,1.67";
      "$mod" = "SUPER";
      "$terminal" = "uwsm app -- ghostty +new-window";
      "$browser" = "uwsm app -- chromium";
      "$menu" = "noctalia-shell ipc call launcher toggle";
      "$pw-manager" = "uwsm app -- 1password";

      bind = [
        "$mod, RETURN, exec, $terminal"
        "$mod, Q, killactive,"
        "$mod, M, exit,"
        "$mod, R, exec, $menu"
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"
        "$mod, B, exec, $browser"
        "$mod, P, exec, $pw-manager"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"

        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"

        "$mod, S, togglespecialworkspace, magic"
        "$mod SHIFT, S, movetoworkspace, special:magic"

        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1" # Keyboard brightness (Super + brightness keys)

        "SUPER, XF86MonBrightnessUp, exec, brightnessctl --device='kbd_backlight' set +10%"
        "SUPER, XF86MonBrightnessDown, exec, brightnessctl --device='kbd_backlight' set 10%-"

        # Regular brightness keys for screen
        ", XF86MonBrightnessUp, exec, brightnessctl set +10%"
        ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+ "
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-      "
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle            "
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle       "
        ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+                   "
        ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-                 "
      ];

      bindl = [
        ", XF86AudioNext, exec, playerctl next        "
        ", XF86AudioPause, exec, playerctl play-pause "
        ", XF86AudioPlay, exec, playerctl play-pause  "
        ", XF86AudioPrev, exec, playerctl previous    "
      ];

      windowrule = {
        name = "suppress-maximize-events";
        "match:class" = ".*";
        suppress_event = "maximize";
      };

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;

        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        resize_on_border = false;

        allow_tearing = false;

        layout = "scrolling";

      };

      decoration = {

        rounding = 20;
        rounding_power = 2;

        # Change transparency of focused and unfocused windows
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };

        # https://wiki.hypr.land/Configuring/Variables/#blur
        blur = {
          enabled = false;
          size = 3;
          passes = 1;

          vibrancy = 0.1696;
        };

      };

      input = {
        kb_layout = "us";
        kb_options = "caps:escape";

        follow_mouse = 1;

        sensitivity = 0;

        touchpad = {
          natural_scroll = true;
        };
      };

      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };

      exec-once = [
        "uwsm app -- systemctl --user start hyprpolkitagent"
        "uwsm app -- 1password --silent"
        "uwsm app -- hyprpaper"
        "uwsm app -- noctalia-shell"
      ];

      animations = {
        enabled = "yes";

        bezier = [
          "snappy, 0.2, 0.9, 0.1, 1.0" # fast start, smooth end
          "overshoot, 0.05, 0.9, 0.1, 1.05" # slight overshoot for bounce
          "instant, 0.05, 0.9, 0.1, 1.0" # nearly instant
        ];

        animation = [
          "windowsIn,    1, 1, snappy, slide" # new windows slide in fast
          "windowsOut,   1, 1, snappy, slide" # close even faster
          "windowsMove,  1, 1, snappy" # tile rearranging
          "workspaces,   1, 1, snappy, slidevert" # workspace transitions with slight overshoot
          "specialWorkspace, 1, 1, snappy, slidevert"
          "fade,         1, 1, instant" # almost no fade
          "fadeDim,      1, 1, snappy"
          "border,       1, 1, snappy"
          "borderangle,  1, 8, snappy, once"
        ];
        # bezier = [
        #   "easeOutQuint,   0.23, 1,    0.16, 1"
        #   "easeInOutCubic, 0.65, 0.05, 0.18, 1"
        #   "linear,         0,    0,    0.5,    1"
        #   "almostLinear,   0.5,  0.5,  0.1, 1"
        #   "quick,          0.15, 0,    0.1,  1"
        # ];
        # animation = [
        #   "global,        1,     10,    default"
        #   "border,        1,     5.39,  easeOutQuint"
        #   "windows,       1,     4.79,  easeOutQuint"
        #   "windowsIn,     1,     4.1,   easeOutQuint, popin 87%"
        #   "windowsOut,    1,     1.49,  linear,       popin 87%"
        #   "fadeIn,        1,     1.73,  almostLinear"
        #   "fadeOut,       1,     1.46,  almostLinear"
        #   "fade,          1,     3.03,  quick"
        #   "layers,        1,     3.81,  easeOutQuint"
        #   "layersIn,      1,     4,     easeOutQuint, fade"
        #   "layersOut,     1,     1.5,   linear,       fade"
        #   "fadeLayersIn,  1,     1.79,  almostLinear"
        #   "fadeLayersOut, 1,     1.39,  almostLinear"
        #   "workspaces,    1,     1.94,  almostLinear, slidevert"
        #   "workspacesIn,  1,     1.21,  almostLinear, slidevert"
        #   "workspacesOut, 1,     1.94,  almostLinear, slidevert"
        #   "zoomFactor,    1,     7,     quick"
        # ];
      };

      misc = {
        vfr = true;
      };
      env = [
        "WLR_DRM_NO_ATOMIC,1"
        "WLR_RENDERER_ALLOW_SOFTWARE,1"
        "__GLX_VENDOR_LIBRARY_NAME,mesa"
        "LIBGL_ALWAYS_SOFTWARE,1"

        "MOZ_ENABLE_WAYLAND,1"
        "MOZ_USE_XINPUT2,1"

        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];
    };
  };
}
