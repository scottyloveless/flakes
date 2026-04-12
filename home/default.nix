{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [
    inputs.lazyvim.homeManagerModules.default # Use inputs
    ./zsh.nix
    ./git.nix
    ./neovim.nix
    ./ghostty.nix
    ./lazyvim.nix
    ./oh-my-posh.nix
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
    firefox
    gcc
    lazygit
    oh-my-posh
    statix # nix linter
    deadnix # nix linter
    pkgs.nixfmt # nix linter
    nixd # nix lsp
    alejandra # nix lsp
    gh
  ];
}
