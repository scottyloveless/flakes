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
