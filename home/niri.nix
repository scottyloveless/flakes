{ config, lib, ... }:
{
  programs.niri.settings = {
    # help asahi find renderD128
    debug = {
      render-drm-device = "/dev/dri/renderD128";
    };
    # Input configuration
    #
    input = {
      keyboard = {
        xkb = {
          layout = "us";
          options = "caps:escape";
        };
      };

      touchpad = {
        natural-scroll = true;
        tap = true;
        dwt = true; # disable while typing
      };

      mouse = {
        accel-profile = "flat";
      };

      focus-follows-mouse = {
        enable = true;
        max-scroll-amount = "0%";
      };
    };

    # Output (monitor) config
    outputs."eDP-1" = {
      scale = 1.67;
      mode = {
        width = 2560;
        height = 1600;
        refresh = 60.000;
      };
    };

    # Layout
    layout = {
      gaps = 8;
      center-focused-column = "never"; # "always" for niri-style centering

      preset-column-widths = [
        { proportion = 0.33333; }
        { proportion = 0.5; }
        { proportion = 0.66667; }
        { proportion = 1.0; }
      ];

      default-column-width = {
        proportion = 0.5;
      };

      focus-ring = {
        enable = true;
        width = 2;
        active.color = "#33ccff";
        inactive.color = "#595959";
      };

      border = {
        enable = false;
      };

      struts = {
        left = 0;
        right = 0;
        top = 0;
        bottom = 0;
      };
    };

    # spawn = at startup
    spawn-at-startup = [
      { command = [ "waybar" ]; }
      {
        command = [
          "1password"
          "--silent"
        ];
      }
    ];

    # Prefer no client-side decorations (cleaner look)
    prefer-no-csd = true;

    # Cursor
    cursor = {
      theme = "Bibata-Modern-Classic";
      size = 24;
    };

    # Environment variables
    environment = {
      DISPLAY = null; # niri is Wayland-only
      MOZ_ENABLE_WAYLAND = "1";
      XCURSOR_SIZE = "24";
      XCURSOR_THEME = "Bibata-Modern-Classic";
    };

    # Hotkey overlay title
    hotkey-overlay.skip-at-startup = true;

    # Screenshots go here
    screenshot-path = "~/Pictures/Screenshots/Screenshot-%Y-%m-%d-%H-%M-%S.png";

    # Animations - snappy feel
    animations = {
      slowdown = 0.5; # make all animations faster globally

      workspace-switch = {
        kind = {
          spring = {
            damping-ratio = 1.0;
            stiffness = 1000;
            epsilon = 0.0001;
          };
        };
      };

      horizontal-view-movement = {
        kind = {
          spring = {
            damping-ratio = 1.0;
            stiffness = 800;
            epsilon = 0.0001;
          };
        };
      };

      window-movement = {
        kind = {
          spring = {
            damping-ratio = 1.0;
            stiffness = 800;
            epsilon = 0.0001;
          };
        };
      };

      window-open = {
        kind = {
          easing = {
            duration-ms = 150;
            curve = "ease-out-quad";
          };
        };
      };

      window-close = {
        kind = {
          easing = {
            duration-ms = 100;
            curve = "ease-out-quad";
          };
        };
      };
    };

    # Window rules
    window-rules = [
      # Round corners and add opacity for inactive windows
      {
        geometry-corner-radius = {
          top-left = 12.0;
          top-right = 12.0;
          bottom-left = 12.0;
          bottom-right = 12.0;
        };
        clip-to-geometry = true;
      }
    ];

    # Keybinds
    binds = with config.lib.niri.actions; {
      # Terminal
      "Mod+Return".action.spawn = = "ghostty";

      # App launcher
      "Mod+Space".action.spawn = = "rofi" "-show" "drun";
      "Mod+R".action.spawn = = "rofi" "-show" "run";

      # Browser & password manager
      "Mod+B".action.spawn = = "chromium";
      "Mod+P".action.spawn = = "1password";

      # Quit app
      "Mod+Q".action = close-window;

      # Exit niri
      "Mod+Shift+E".action = quit;

      # Lock
      "Mod+Shift+Q".action.spawn = = "hyprlock";

      # Focus column navigation (left/right along the scroll)
      "Mod+H".action = focus-column-left;
      "Mod+L".action = focus-column-right;

      # Focus window up/down within column
      "Mod+K".action = focus-window-up;
      "Mod+J".action = focus-window-down;

      # Move columns
      "Mod+Shift+H".action = move-column-left;
      "Mod+Shift+L".action = move-column-right;

      # Move windows within/between columns
      "Mod+Shift+K".action = move-window-up;
      "Mod+Shift+J".action = move-window-down;

      # Consume/expel windows into columns (unique to niri)
      "Mod+Comma".action = consume-window-into-column;
      "Mod+Period".action = expel-window-from-column;

      # Column width presets
      "Mod+1".action.focus-workspace = [1 ] ;
      "Mod+2".action.focus-workspace = [2];
      "Mod+3".action.focus-workspace = [3];
      "Mod+4".action.focus-workspace = [4] ;
      "Mod+5".action.focus-workspace = [5];

      # Move to workspace
      "Mod+Shift+1".action.move-column-to-workspace = [ 1 ];
      "Mod+Shift+2".action.move-column-to-workspace = [ 2 ];
      "Mod+Shift+3".action.move-column-to-workspace = [ 3 ];
      "Mod+Shift+4".action.move-column-to-workspace = [ 4 ];
      "Mod+Shift+5".action.move-column-to-workspace = [ 5 ];

      # Column width (cycle through presets)
      "Mod+Minus".action.set-column-width = "-10%";
      "Mod+Equal".action.set-column-width  = "+10%";
      "Mod+0".action = reset-window-height;

      # Fullscreen
      "Mod+F".action = fullscreen-window;

      # Center current column
      "Mod+C".action = center-column;

      # Column width cycling (like niri's "switch to next preset")
      "Mod+W".action = switch-preset-column-width;

      # Screenshots
      "Print".action = screenshot;
      "Shift+Print".action = screenshot-screen;
      "Mod+Shift+S".action = screenshot;

      # Volume
      "XF86AudioRaiseVolume".action.spawn = "wpctl" "set-volume" "-l" "1" "@DEFAULT_AUDIO_SINK@" "5%+";
      "XF86AudioLowerVolume".action.spawn = "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-";
      "XF86AudioMute".action.spawn = "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
      "XF86AudioMicMute".action.spawn = "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";

      # Media keys
      "XF86AudioNext".action.spawn = "playerctl" "next";
      "XF86AudioPlay".action.spawn = "playerctl" "play-pause";
      "XF86AudioPause".action.spawn = "playerctl" "play-pause";
      "XF86AudioPrev".action.spawn = "playerctl" "previous";

      # Brightness
      "XF86MonBrightnessUp".action.spawn = "brightnessctl" "set" "+10%";
      "XF86MonBrightnessDown".action.spawn = "brightnessctl" "set" "10%-";
      "Mod+XF86MonBrightnessUp".action.spawn = "brightnessctl" "--device=kbd_backlight" "set" "+10%";
      "Mod+XF86MonBrightnessDown".action.spawn = "brightnessctl" "--device=kbd_backlight" "set" "10%-";
    };
  };
}
