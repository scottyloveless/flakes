{
  pkgs,
  lib,
  osConfig,
  ...
}:
let
  hasNvidia = lib.elem "nvidia" osConfig.services.xserver.videoDrivers;
  isLaptop = lib.elem osConfig.networking.hostName [
    "beau"
    "intel-mac"
  ];
in
{
  home.packages = [ pkgs.hyprshot ];

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  services.hyprpolkitagent.enable = true;
  services.hyprpaper = {
    enable = true;
    settings = {
      wallpaper = [
        {
          monitor = "";
          path = "~/wallpapers/landscape2.jpg";
        }
      ];
      splash = false;
    };
  };

  # Nvidia vars break GLX/VA-API on non-Nvidia hosts, so only set them where the driver is loaded
  xdg.configFile."uwsm/env".text = ''
    ${lib.optionalString hasNvidia ''
      export LIBVA_DRIVER_NAME=nvidia
      export __GLX_VENDOR_LIBRARY_NAME=nvidia
      export NVD_BACKEND=direct
    ''}export XCURSOR_THEME=Bibata-Modern-Classic
    export XCURSOR_SIZE=24
  '';

  xdg.configFile."uwsm/env-hyprland".text = ''
    export HYPRCURSOR_SIZE=24
  '';

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    # Writes ~/.config/hypr/hyprland.lua. Each `settings` attr becomes an hl.<name>(...) call;
    # binds and autostart live in extraConfig as plain Lua since they take dispatcher objects.
    configType = "lua";
    systemd.enable = false;

    settings = {
      monitor = [
        {
          output = "HDMI-A-1";
          mode = "3840x2160@240";
          position = "0x0";
          scale = 1.666667;
          bitdepth = 10;
          # sRGB desktop: "auto"/"wide" picks BT.2020 here, which looks washed out on this
          # AW3225QF. HDR is only entered for fullscreen HDR games (render:cm_auto_hdr).
          cm = "srgb";

          # HDR luminance overrides (nits), used when auto-HDR switches the monitor
          max_luminance = 1000; # peak brightness
          min_luminance = 0; # black level (near-zero for OLED)

          # SDR content inside HDR mode. Single knob for desktop brightness:
          # replaces the old sdr_max_luminance 200 x sdrbrightness 0.5 combo.
          sdr_max_luminance = 100; # SDR white (nits)
          sdr_min_luminance = 0;
        }

        {
      output = "desc:Dell Inc. AW3225QF XXXXXXX";
      mode = "3840x2160@240";
      position = "0x0";
      scale = 1.666667;
      bitdepth = 10;
      cm = "srgb";
      max_luminance = 1000;
      min_luminance = 0;
      sdr_max_luminance = 100;
      sdr_min_luminance = 0;
    }

    # LG B5 65" OLED (couch)
    {
      output = "desc:LG Electronics LG TV SSCR2 0x01010101";
      mode = "3840x2160@120";
      position = "0x0";
      scale = 2; # 1920x1080 logical, readable from a couch
      bitdepth = 10;
      cm = "srgb";
      max_luminance = 830; # starting point, tune by eye
      min_luminance = 0;
      sdr_max_luminance = 100;
      sdr_min_luminance = 0;
    }
        {
      output = "";
      mode = "preferred";
      position = "auto";
      scale = 1;
    }
      ];

      # Trying niri-style columns on workspace 2; the rest stay on general.layout (dwindle)
      workspace_rule = {
        workspace = "2";
        layout = "scrolling";
      };

      # Frosted-glass Quickshell bar; ignore_alpha keeps the transparent corners unblurred
      layer_rule = {
        name = "quickshell-bar-blur";
        match.namespace = "^quickshell:bar$";
        blur = true;
        ignore_alpha = 0.3;
      };

      window_rule = [
        {
          name = "suppress-maximize-events";
          match.class = ".*";
          suppress_event = "maximize";
        }
        {
          # Let games tear (needs general.allow_tearing)
          name = "games-allow-tearing";
          match.class = "^(steam_app_.*)$";
          immediate = true;
        }
      ];

      config = {
        general = {
          gaps_in = 5;
          gaps_out = 10;
          border_size = 2;

          col = {
            active_border = {
              colors = [
                "rgba(33ccffee)"
                "rgba(00ff99ee)"
              ];
              angle = 45;
            };
            inactive_border = "rgba(595959aa)";
          };

          resize_on_border = false;

          allow_tearing = true;

          layout = "dwindle";
        };

        misc = {
          vrr = 2;
          # hyprpaper handles the wallpaper; don't flash the default one first
          force_default_wallpaper = 0;
          disable_hyprland_logo = true;
        };

        render = {
          cm_auto_hdr = 1;
          direct_scanout = 2;
        };

        # Advertise HDR to gamescope only, so HDR games run in gamescope can enable it
        # while the desktop stays SDR (Wine-Wayland HDR still looks wrong on Nvidia).
        quirks = {
          prefer_hdr = 2;
        };

        cursor = {
          # Auto: software cursor on Nvidia while VRR is active (fullscreen games), which
          # avoids the over-bright hardware cursor in HDR and allows tearing.
          no_hardware_cursors = 2;
        };

        xwayland = {
          force_zero_scaling = true;
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

          blur = {
            enabled = true;
            size = 6;
            passes = 2;

            vibrancy = 0.1696;
            new_optimizations = true;
          };
        };

        input = {
          kb_layout = "us";
          kb_options = "caps:escape,altwin:swap_alt_win";

          repeat_delay = 300;
          repeat_rate = 40;

          follow_mouse = 1;

          sensitivity = 0;

          touchpad = {
            natural_scroll = true;
          };
        };

        dwindle = {
          preserve_split = true;
        };
      };

      # curve is in importantPrefixes, so these are emitted before the animations that use them.
      # Springs ignore `speed`: their duration falls out of the physics, and they carry velocity
      # into a retargeted animation, so interrupting a move/resize stays smooth instead of restarting.
      # Times below are to 95% of travel (zeta = damping ratio, < 1 overshoots).
      curve =
        lib.mapAttrsToList
          (name: points: {
            _args = [
              name
              {
                type = "bezier";
                inherit points;
              }
            ];
          })
          {
            easeOutQuint = [
              [
                0.23
                1
              ]
              [
                0.32
                1
              ]
            ];
            easeInQuad = [
              [
                0.55
                0.085
              ]
              [
                0.68
                0.53
              ]
            ];
            quick = [
              [
                0.15
                0
              ]
              [
                0.1
                1
              ]
            ];
          }
        ++
          lib.mapAttrsToList
            (name: spring: {
              _args = [
                name
                (
                  {
                    type = "spring";
                    mass = 1;
                  }
                  // spring
                )
              ];
            })
            {
              # ~110ms, zeta 0.8 (0.7% overshoot): window moves, resizes, tiling reflows
              snap = {
                stiffness = 1000;
                dampening = 50.6;
              };
              # ~105ms, zeta 0.72 (2.8% overshoot): a small bounce on window open
              pop = {
                stiffness = 800;
                dampening = 40.7;
              };
              # ~120ms, zeta 0.9 (no overshoot): workspace switches, so no neighbour peeks past the edge
              glide = {
                stiffness = 1200;
                dampening = 62.4;
              };
            };

      # speed is in units of 100ms and only applies to bezier animations
      animation = map (a: { enabled = true; } // a) [
        {
          leaf = "global";
          speed = 10;
          bezier = "default";
        }
        {
          leaf = "border";
          speed = 2.5;
          bezier = "easeOutQuint";
        }
        {
          leaf = "windows";
          speed = 1;
          spring = "snap";
        }
        {
          leaf = "windowsIn";
          speed = 1;
          spring = "pop";
          style = "popin 85%";
        }
        # with no fade to hide the end, closing shrinks all the way into the window's centre
        {
          leaf = "windowsOut";
          speed = 1.5;
          bezier = "easeInQuad";
          style = "popin 0%";
        }
        # no opacity animations anywhere (open/close, dim, dpms, popups): nothing goes see-through
        {
          leaf = "fade";
          enabled = false;
        }
        {
          leaf = "layers";
          speed = 1;
          spring = "snap";
        }
        {
          leaf = "layersIn";
          speed = 1;
          spring = "pop";
          style = "popin 92%";
        }
        {
          leaf = "layersOut";
          speed = 1.2;
          bezier = "easeInQuad";
          style = "popin 0%";
        }
        {
          leaf = "workspaces";
          speed = 1;
          spring = "glide";
          style = "slidevert";
        }
        {
          leaf = "zoomFactor";
          speed = 3;
          bezier = "quick";
        }
      ];
    };

    extraConfig = ''
      local mod = "SUPER"
      local terminal = "uwsm app -- ghostty +new-window"
      local browser = "uwsm app -- chromium"
      local pwManager = "uwsm app -- 1password"

      local exec = hl.dsp.exec_cmd

      hl.bind(mod .. " + RETURN", exec(terminal))
      hl.bind(mod .. " + Q", hl.dsp.window.close())
      hl.bind(mod .. " + M", exec("uwsm stop"))
      hl.bind(mod .. " + H", hl.dsp.focus({ direction = "left" }))
      hl.bind(mod .. " + L", hl.dsp.focus({ direction = "right" }))
      hl.bind(mod .. " + K", hl.dsp.focus({ direction = "up" }))
      hl.bind(mod .. " + J", hl.dsp.focus({ direction = "down" }))
      hl.bind(mod .. " + B", exec(browser))
      hl.bind(mod .. " + P", exec(pwManager))
      hl.bind(mod .. " + A", exec("claude-app"))

      for i = 1, 5 do
        hl.bind(mod .. " + " .. i, hl.dsp.focus({ workspace = i }))
        hl.bind(mod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
      end

      hl.bind(mod .. " + S", hl.dsp.workspace.toggle_special("magic"))
      hl.bind(mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

      hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
      hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

      -- App launcher
      hl.bind(mod .. " + SPACE", exec("uwsm app -- rofi -show drun"))
      hl.bind(mod .. " + R", exec("uwsm app -- rofi -show run"))

      -- Lock (via hypridle's lock_cmd, so only one hyprlock runs)
      hl.bind(mod .. " + SHIFT + L", exec("loginctl lock-session"))

      -- Screenshots: region / monitor / window, saved and copied to clipboard
      hl.bind("Print", exec("hyprshot -m region -o ~/Pictures/Screenshots"))
      hl.bind("SHIFT + Print", exec("hyprshot -m output -o ~/Pictures/Screenshots"))
      hl.bind(mod .. " + Print", exec("hyprshot -m window -o ~/Pictures/Screenshots"))
    ''
    + lib.optionalString isLaptop ''

      -- Keyboard backlight (Super + brightness keys)
      hl.bind(mod .. " + XF86MonBrightnessUp", exec("brightnessctl --device='kbd_backlight' set +10%"))
      hl.bind(mod .. " + XF86MonBrightnessDown", exec("brightnessctl --device='kbd_backlight' set 10%-"))

      -- Screen backlight
      hl.bind("XF86MonBrightnessUp", exec("brightnessctl set +10%"))
      hl.bind("XF86MonBrightnessDown", exec("brightnessctl set 10%-"))
    ''
    + ''

      -- Move/resize windows with mod + LMB/RMB and dragging
      hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
      hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

      -- Volume (was bindel): works while locked, repeats while held
      local lockedRepeat = { locked = true, repeating = true }
      hl.bind("XF86AudioRaiseVolume", exec("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), lockedRepeat)
      hl.bind("XF86AudioLowerVolume", exec("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), lockedRepeat)
      hl.bind("XF86AudioMute", exec("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), lockedRepeat)
      hl.bind("XF86AudioMicMute", exec("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), lockedRepeat)

      -- Media (was bindl): works while locked
      hl.bind("XF86AudioNext", exec("playerctl next"), { locked = true })
      hl.bind("XF86AudioPause", exec("playerctl play-pause"), { locked = true })
      hl.bind("XF86AudioPlay", exec("playerctl play-pause"), { locked = true })
      hl.bind("XF86AudioPrev", exec("playerctl previous"), { locked = true })

      hl.on("hyprland.start", function()
        hl.exec_cmd("uwsm app -- 1password --silent")
      end)
    '';
  };
}
