{ pkgs, ... }:
{
  imports = [
    ./default.nix # shared: zsh, git, neovim, packages
  ];

  # macOS-specific packages
  home.packages = with pkgs; [
    mas # Mac App Store CLI
    rectangle # window snapping (if not using Aerospace)
    pkgs.ghostty-bin
  ];
}
