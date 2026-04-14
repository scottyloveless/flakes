{ pkgs, ... }:
{

  security.sudo.wheelNeedsPassword = false;
  programs.hyprland.enable = true;

  services.gnome.gnome-keyring.enable = true;

  users.users.mox = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ]; # Enable ‘sudo’ for the user.
    #   packages = with pkgs; [
    #     tree
    #   ];
    home = "/home/mox";
    shell = pkgs.zsh;
    description = "mox";
  };

  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  services.tuned.enable = true;
  services.upower.enable = true;
  # networking.wireless.iwd = {
  #   enable = true;
  #   settings.General.EnableNetworkConfiguration = true;
  # };
}
