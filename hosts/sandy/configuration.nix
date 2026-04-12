{ config, pkgs, ... }:
{
  # macOS system packages (available to all users)
  environment.systemPackages = with pkgs; [
    git
    curl
    wget
  ];

  # Allow proprietary packages
  nixpkgs.config.allowUnfree = true;

  # Auto-upgrade nix
  services.nix-daemon.enable = true;
  nix.settings.experimental-features = [
    "nix-flakes"
    "nix-command"
  ];

  users.users.mox = {
    home = "/Users/mox";
    shell = pkgs.zsh;
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

  system.stateVersion = 5;
}
