{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [
    # inputs.noctalia.homeModules.default
    # ./textfox.nix
    # ./noctalia.nix
    ./default.nix
    ./hyprland.nix
    ./ghostty.nix
    ./waybar.nix
    ./rofi.nix
    ./dunst.nix
    ./hypridle.nix
    ./chromium.nix
    ./hyprlock.nix
    ./niri.nix
  ];

  home.packages = with pkgs; [
    swaybg
  ];
}
