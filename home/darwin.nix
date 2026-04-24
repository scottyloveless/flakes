{ pkgs, ... }:
{
  imports = [
    ./default.nix # shared: zsh, git, neovim, packages
    # ./rift.nix
  ];

  # macOS-specific packages
  home.packages = with pkgs; [
    mas # Mac App Store CLI
    betterdisplay
    pkgs.sqlfluff
  ];
}
