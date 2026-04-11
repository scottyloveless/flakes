# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.cantouchefivariables = true;

  # hyprland
  # programs.hyprland = {
  #     enable = true;
  #     package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  #   };
  
	#  # hyprland
	 programs.hyprland.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  environment.systempackages = with pkgs; [ git curl wget ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  virtualisation.vmware.guest.enable = true;

	#  # use latest kernel.
	 # boot.kernelpackages = pkgs.linuxpackages_latest;
	#
	 networking.hostname = "nixos-fusion"; # define your hostname.
	#  # networking.wireless.enable = true;  # enables wireless support via wpa_supplicant.
	#
	#  # configure network proxy if necessary
	#  # networking.proxy.default = "http://user:password@proxy:port/";
	#  # networking.proxy.noproxy = "127.0.0.1,localhost,internal.domain";
	#
	#  # enable networking
	 networking.networkmanager.enable = true;
	#
	#  # set your time zone.
	 time.timezone = "america/chicago";
	#
	#  # select internationalisation properties.
	 i18n.defaultlocale = "en_us.utf-8";
	#
	 i18n.extralocalesettings = {
	   lc_address = "en_us.utf-8";
	   lc_identification = "en_us.utf-8";
	   lc_measurement = "en_us.utf-8";
	   lc_monetary = "en_us.utf-8";
	   lc_name = "en_us.utf-8";
	   lc_numeric = "en_us.utf-8";
	   lc_paper = "en_us.utf-8";
	   lc_telephone = "en_us.utf-8";
	   lc_time = "en_us.utf-8";
	 };
	#
	#  # configure keymap in x11
	#  services.xserver.xkb = {
	#    layout = "us";
	#    variant = "";
	#  };
	#
	#  # flakes
	#  nix.settings.experimental-features = [ "nix-command" "flakes" ];
	#
	#  # define a user account. don't forget to set a password with ‘passwd’.
	 users.users.mox = {
	   isnormaluser = true;
	   description = "mox";
	   extragroups = [ "networkmanager" "wheel" ];
	#    packages = with pkgs; [
	#    	stow
	# yazi
	# eza
	# zoxide
	# oh-my-posh
	# wofi
	#    ];
	 };
	#
	#  # zsh
	#  programs.zsh.enable = true;
	#  users.defaultusershell = pkgs.zsh;
	#
	#
	#  # open-vm-tools
	#  virtualisation.vmware.guest.enable = true;
	#
	#  # noctalia shell
	#  # hardware.bluetooth.enable = true;
	#  # services.power-profiles-daemon.enable = true;
	#  # services.upower.enable = true;
	#  # services.tuned.enable = true; 
	#
	#  # list packages installed in system profile. to search, run:
	#  # $ nix search wget
	#  environment.systempackages = with pkgs; [
	#  #  vim # do not forget to add an editor to edit configuration.nix! the nano editor is also installed by default.
	#  #  wget
	# neovim
	# firefox
	# git
	# ghostty
	# fzf
	# gcc
	#  ];

  # some programs need suid wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enablesshsupport = true;
  # };

  # list services that you want to enable:

  # enable the openssh daemon.
  # services.openssh.enable = true;

  # open ports in the firewall.
  # networking.firewall.allowedtcpports = [ ... ];
  # networking.firewall.allowedudpports = [ ... ];
  # or disable the firewall altogether.
  # networking.firewall.enable = false;

  # this value determines the nixos release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. it‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateversion = "25.11"; # did you read the comment?

}
