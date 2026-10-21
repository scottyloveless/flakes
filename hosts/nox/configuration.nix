# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/linuxcommon.nix
    ../../modules/common.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages;

  networking.hostName = "nox"; # Define your hostname.

  nixpkgs.config.allowUnfree = true;

  networking.networkmanager.enable = true;

  # Enable OpenGL / hardware graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = [ pkgs.nvidia-vaapi-driver ]; # Recommended for Steam / 32-bit games
  };

  # Load Nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Modesetting is required for most Wayland compositors and modern setups
    modesetting.enable = true;

    # Use open-source kernel modules (recommended for Turing/RTX 20-series and newer)
    # Set to false for older cards like GTX 10-series or earlier
    open = true;

    # Enable Nvidia Settings menu
    nvidiaSettings = true;

    # Select driver package (stable, production, beta, etc.)
    package = config.boot.kernelPackages.nvidiaPackages.beta;

    powerManagement.enable = true;
  };

  programs.steam = {
    enable = true;
    protontricks.enable = true;
    gamescopeSession.enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };
  programs.gamemode.enable = true;
}
