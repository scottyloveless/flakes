{ config, pkgs, ... }:
{
    imports = [
      ./zsh.nix
      ./git.nix
      ./neovim.nix
      ./ghostty.nix
      ./hyprland.nix
    ];

    home.username = "mox";
    home.homeDirectory = "/home/mox";
    home.stateVersion = "26.05";

    programs.home-manager.enable = true;

    home.packages = with pkgs; [
      ripgrep
      fd
      fzf
      bat
      eza
      btop
      pkgs.kitty
    ];
  }
