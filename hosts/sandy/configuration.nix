{ config, pkgs, ... }:
{
  # macOS system packages (available to all users)
  environment.systemPackages = with pkgs; [
    git
    curl
    wget
  ];
  nix.enable = false;

  # Allow proprietary packages
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  users.users.mox = {
    home = "/Users/mox";
    shell = pkgs.zsh;
  };
  system.primaryUser = "mox";
  security.pam.services.sudo_local.touchIdAuth = true;

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap"; # removes anything not declared here
    };

    taps = [
    ];

    brews = [
      # add any formulae that aren't available in nixpkgs
    ];

    casks = [
    ];

    masApps = {
      # "App Name" = App Store ID;
    };
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];

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

  # Used by nix-darwin internals — must match your macOS hostname
  networking.hostName = "sandy";

  environment.systemPath = [
    "/etc/profiles/per-user/mox/bin"
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
  ];

  system.stateVersion = 5;
}
