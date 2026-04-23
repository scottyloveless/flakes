{
  pkgs,
  inputs,
  config,
  ...
}:
{

  users.users.mox = {
    home = "/Users/mox";
    shell = pkgs.zsh;
  };
  system.primaryUser = "mox";
  security.pam.services.sudo_local.touchIdAuth = true;
  nix.enable = false;
  environment.variables.SSH_AUTH_SOCK = "~/Library/Group Containers/2BU85C4YRE.com.1password/t/agent.sock";

  # macOS system defaults
  system.defaults = {
    dock = {
      autohide = true;
      show-recents = false;
      mru-spaces = false;
    };
    finder = {
      AppleShowAllExtensions = true;
      FXPreferredViewStyle = "clmv"; # column view
      ShowPathbar = true;
    };
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      KeyRepeat = 2;
      InitialKeyRepeat = 15;
    };
  };

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_17;

    settings = {
      shared_preload_libraries = "timescaledb";
      "timescaledb.telemetry_level" = "off";
    };
  };

  services.jankyborders = {
    enable = true;
    active_color = "0xff7DCFFF";
    inactive_color = "0xff24283A";
    hidpi = true;
    width = 4.0;
  };

  nix-homebrew = {
    enable = true;
    enableRosetta = false;
    user = "mox";
    autoMigrate = true;

    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
      "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
      "acsandmann/homebrew-tap" = inputs.acsandmann-tap;
      "BarutSRB/homebrew-tap" = inputs.barutsrb-tap;
    };
    mutableTaps = false;
  };

  homebrew = {
    enable = true;

    # onActivation = {
    #   autoUpdate = true;
    #   upgrade = true;
    #   cleanup = "zap"; # removes anything not declared here
    # };

    taps = builtins.attrValues {
      "homebrew/homebrew-core" = "homebrew/homebrew-core";
      "homebrew/homebrew-cask" = "homebrew/homebrew-cask";
      "acsandmann/homebrew-tap" = "acsandmann/homebrew-tap";
      "BarutSRB/homebrew-tap" = "BarutSRB/homebrew-tap";
    };

    brews = [
      "acsandmann/homebrew-tap/rift"
    ];

    casks = [
      "pearcleaner"
      "vivaldi"
      "BarutSRB/homebrew-tap/omniwm"
    ];

    masApps = {
      # "App Name" = App Store ID;
    };
  };

  environment.systemPath = [
    "/etc/profiles/per-user/mox/bin"
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
  ];

  system.stateVersion = 5;

  services.aerospace = {
    enable = false;
    settings = {
      after-login-command = [ ];

      # Uncomment when sketchybar is installed
      # exec-on-workspace-change = [
      #   "/bin/bash"
      #   "-c"
      #   "sketchybar --trigger aerospace_workspace_change FOCUSED_WORKSPACE=$AEROSPACE_FOCUSED_WORKSPACE"
      # ];

      enable-normalization-flatten-containers = true;
      enable-normalization-opposite-orientation-for-nested-containers = true;

      accordion-padding = 30;
      default-root-container-layout = "tiles";
      default-root-container-orientation = "auto";

      key-mapping.preset = "qwerty";

      on-focused-monitor-changed = [ "move-mouse monitor-lazy-center" ];
      on-focus-changed = [ "move-mouse window-lazy-center" ];

      gaps = {
        inner.horizontal = 12;
        inner.vertical = 12;
        outer.left = 12;
        outer.bottom = 12;
        outer.top = [
          { monitor."built-in" = 12; }
          40
        ];
        outer.right = 12;
      };

      mode.main.binding = {
        cmd-h = [ ];
        cmd-alt-h = [ ];
        cmd-m = [ ];

        alt-enter = "exec-and-forget osascript -e 'tell application \"Ghostty\" to new window'";

        alt-slash = "layout tiles horizontal vertical";
        alt-comma = "layout accordion horizontal vertical";

        alt-h = "focus left";
        alt-j = "focus down";
        alt-k = "focus up";
        alt-l = "focus right";

        alt-b = ''exec-and-forget osascript -e 'tell application "Safari" to make new document' '';

        alt-shift-h = "move left";
        alt-shift-j = "move down";
        alt-shift-k = "move up";
        alt-shift-l = "move right";

        alt-shift-minus = "resize smart -50";
        alt-shift-equal = "resize smart +50";

        alt-1 = "workspace 1";
        alt-2 = "workspace 2";
        alt-3 = "workspace 3";
        alt-4 = "workspace 4";
        alt-5 = "workspace 5";
        alt-e = "workspace E";
        alt-q = "workspace Q";
        alt-r = "workspace R";
        alt-w = "workspace W";

        alt-shift-1 = "move-node-to-workspace 1";
        alt-shift-2 = "move-node-to-workspace 2";
        alt-shift-3 = "move-node-to-workspace 3";
        alt-shift-4 = "move-node-to-workspace 4";
        alt-shift-5 = "move-node-to-workspace 5";
        alt-shift-e = "move-node-to-workspace E";
        alt-shift-f = "fullscreen";
        alt-shift-q = "move-node-to-workspace Q";
        alt-shift-r = "move-node-to-workspace R";
        alt-shift-w = "move-node-to-workspace W";

        alt-tab = "workspace-back-and-forth";
        alt-shift-tab = "move-workspace-to-monitor --wrap-around next";

        alt-shift-semicolon = "mode service";
      };

      mode.service.binding = {
        esc = [
          "reload-config"
          "mode main"
        ];
        r = [
          "flatten-workspace-tree"
          "mode main"
        ];
        f = [
          "layout floating tiling"
          "mode main"
        ];
        backspace = [
          "close-all-windows-but-current"
          "mode main"
        ];

        alt-shift-h = [
          "join-with left"
          "mode main"
        ];
        alt-shift-j = [
          "join-with down"
          "mode main"
        ];
        alt-shift-k = [
          "join-with up"
          "mode main"
        ];
        alt-shift-l = [
          "join-with right"
          "mode main"
        ];
      };

      on-window-detected = [
        {
          "if"."app-id" = "com.apple.ActivityMonitor";
          run = "layout floating";
        }
        {
          "if"."app-id" = "com.codeweavers.CrossOver";
          run = "layout floating";
        }
        {
          "if"."app-id" = "com.ninjarmm.ncplayer";
          run = "move-node-to-workspace E";
        }
        {
          "if"."app-id" = "org.whispersystems.signal-desktop";
          run = "move-node-to-workspace Q";
        }
        {
          "if"."app-id" = "com.apple.MobileSMS";
          run = "move-node-to-workspace Q";
        }
        {
          "if"."app-id" = "com.microsoft.teams2";
          run = "move-node-to-workspace W";
        }
        {
          "if"."app-id" = "com.google.Chrome";
          run = "move-node-to-workspace 2";
        }
      ];
    };
  };
}
