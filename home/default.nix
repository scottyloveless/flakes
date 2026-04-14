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
    ./lazyvim.nix
    ./oh-my-posh.nix
    ./ghostty.nix
    ./ssh.nix
    ./1password-shell.nix
  ];

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
