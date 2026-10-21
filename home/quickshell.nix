{ config, ... }:
let
  # true: ~/.config/quickshell/shell symlinks to this repo's working tree, so QML edits
  # hot-reload without a rebuild; git is the version history. false: the QML is copied
  # into the Nix store, pinned to the generation, and rolls back with it.
  live = true;
in
{
  programs.quickshell = {
    enable = true;
    configs.shell =
      if live then
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/flakes/home/quickshell"
      else
        ./quickshell;
    activeConfig = "shell";
    # Starts with graphical-session.target, which uwsm brings up for Hyprland
    systemd.enable = true;
  };
}
