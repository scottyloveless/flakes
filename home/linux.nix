{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [
    inputs.noctalia.homeModules.default
    ./default.nix
    ./hyprland.nix
    ./noctalia.nix
  ];
}
