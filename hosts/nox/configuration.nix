# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  inputs,
  config,
  pkgs,
  ...
}:

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

  # Default (LTS) kernel — safer with nvidiaPackages.latest than linuxPackages_latest.
  boot.kernelPackages = pkgs.linuxPackages;

  networking.hostName = "nox"; # Define your hostname.

  nixpkgs.config.allowUnfree = true;

  networking.networkmanager.enable = true;

  # Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true; # Steam / Proton
    pulse.enable = true;
  };

  environment.systemPackages = with pkgs; [
    pavucontrol # waybar pulseaudio on-click
    playerctl # media keys
  ];

  # Enable OpenGL / hardware graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = [
      pkgs.nvidia-vaapi-driver
      # pkgs.vulkan-hdr-layer-kwin6
    ]; # Recommended for Steam / 32-bit games
    # extraPackages32 = [ pkgs.pkgsi686Linux.vulkan-hdr-layer-kwin6 ];
  };

  # Load Nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Modesetting is required for most Wayland compositors and modern setups
    modesetting.enable = true;

    # Open kernel modules are required for Blackwell (RTX 50-series)
    open = true;

    # Enable Nvidia Settings menu
    nvidiaSettings = true;

    # Select driver package (stable, production, beta, etc.)
    package = config.boot.kernelPackages.nvidiaPackages.latest;

    powerManagement.enable = true;
  };

  programs.steam = {
    enable = true;
    protontricks.enable = true;
    gamescopeSession.enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
    # gamescope's Vulkan WSI layer, needed for HDR in games run under gamescope
    extraPackages = [ pkgs.gamescope-wsi ];
  };
  programs.gamemode.enable = true;
  users.users.mox.extraGroups = [ "gamemode" ];

  system.stateVersion = "26.05"; # NixOS release nox was installed with
}
