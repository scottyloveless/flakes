{ pkgs, ... }:
{
  imports = [
    ./default.nix # shared: zsh, git, neovim, packages
    ./aerospace.nix
  ];

  # macOS-specific packages
  home.packages = with pkgs; [
    mas # Mac App Store CLI
    aerospace
  ];
}
