{ pkgs, ... }:
{

  security.sudo.wheelNeedsPassword = false;

  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  programs.uwsm = {
    enable = true;
    waylandCompositors.hyprland = {
      prettyName = "Hyprland";
      comment = "Hyprland compositor managed by UWSM";
      binPath = "/run/current-system/sw/bin/Hyprland";
    };
  };
  services.gnome.gnome-keyring.enable = true;

  users.users.mox = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
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

  # hardware.pulseaudio.enable = true; #this conflicts with Apple silicon support
  # hardware.pulseaudio.support32Bit = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd 'uwsm start hyprland-uwsm.desktop'";
        # command = "${pkgs.tuigreet}/bin/tuigreen --time --remember --cmd /usr/bin/start-hyprland";
        user = "greeter";
      };
    };
  };
}
