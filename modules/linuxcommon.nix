{ pkgs, ... }:
{
  networking.wireless.iwd = {
    enable = true;
    settings.General.EnableNetworkConfiguration = true;
  };

  security.sudo.wheelNeedsPassword = false;
  programs.hyprland.enable = true;

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
}
