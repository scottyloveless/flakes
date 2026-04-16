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
    ./1password.nix
    # ./firefox.nix
    ./chromium.nix
  ];

  programs.home-manager.enable = true;
  programs.zoxide.enable = true;
  programs.zoxide.options = [
    "--cmd cd"
  ];

  home.packages = with pkgs; [
    ripgrep
    fd
    fzf
    bat
    eza
    btop
    gcc
    lazygit
    oh-my-posh
    statix # nix linter
    deadnix # nix linter
    pkgs.nixfmt # nix linter
    nixd # nix lsp
    alejandra # nix lsp
    gh
    yazi
    zoxide
    pkgs.weechat
  ];
}
