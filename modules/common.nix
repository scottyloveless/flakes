{ pkgs, lib, ... }:
{
  time.timeZone = "America/Chicago";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.download-buffer-size = 500 * 1024 * 1024;
  environment.systemPackages = with pkgs; [
    git
    curl
    wget
    cachix
  ];

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "discord"
      "_1password"
      "_1password-gui"
      "1password-cli"
      "1password"
      "betterdisplay"
      "timescaledb"
    ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    font-awesome_4
  ];

  programs.zsh.enable = true;

  environment.shells = with pkgs; [ zsh ];

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
  };

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_17;

    extraConfig = with pkgs.postgresql_17.pkgs; [ timescaledb ];

    settings = {
      shared_preload_libraries = "timescaledb";
      "timescaledb.telemetry_level" = "off";
    };
  };

  # programs.steam = {
  #   enable = true;
  # };

  system.stateVersion = "25.11";
}
