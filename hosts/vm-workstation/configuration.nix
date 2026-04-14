# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  imports = [
    # include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/linuxcommon.nix
    ../../modules/common.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  virtualisation.vmware.guest.enable = true;
  services.xserver.videoDrivers = [ "vmware" ];

  networking.networkmanager.enable = true;
  networking.hostName = "vm-workstation"; # define your hostname.

}
