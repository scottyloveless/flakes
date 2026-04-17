{ pkgs, ... }:
{

  security.sudo.wheelNeedsPassword = false;

  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
  programs.niri.enable = true;

  programs.niri.enable = true;

  environment.variables.SSH_AUTH_SOCK = "~/.1password/agent.sock";
  # boot.kernelPackages = pkgs.linuxPackages_latest;

  i18n.defaultLocale = "en_US.UTF-8";

  programs.uwsm = {
    enable = true;
    # waylandCompositors.hyprland = {
    #   prettyName = "Hyprland";
    #   comment = "Hyprland compositor managed by UWSM";
    #   binPath = "/run/current-system/sw/bin/Hyprland";
    # };
  };
  services.gnome.gnome-keyring.enable = true;

  users.users.mox = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
    ]; # Enable ‘sudo’ for the user.
    #   packages = with pkgs; [
    #     tree
    #   ];
    #

    home = "/home/mox";
    shell = pkgs.zsh;
    description = "mox";
  };

  hardware.bluetooth.enable = true;
  services.tuned.enable = true;
  services.upower.enable = true;

  programs._1password-gui = {
    polkitPolicyOwners = [ "mox" ];
  };

  security.polkit.enable = true;
  # hardware.pulseaudio.enable = true; #this conflicts with Apple silicon support
  # hardware.pulseaudio.support32Bit = true;

  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     default_session = {
  #       command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd 'uwsm start hyprland-uwsm.desktop'";
  #       # command = "${pkgs.tuigreet}/bin/tuigreen --time --remember --cmd /usr/bin/start-hyprland";
  #       user = "greeter";
  #     };
  #   };
  # };
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = ''
          ${pkgs.tuigreet}/bin/tuigreet \
            --time \
            --remember \
            --remember-user-session \
            --asterisks \
            --sessions /run/current-system/sw/share/wayland-sessions \
            --theme 'border=blue;text=cyan;prompt=magenta;time=blue;action=blue;button=magenta;container=black;input=cyan' \
        '';
        user = "greeter";
      };
    };
  };

  console = {
    earlySetup = true;
    colors = [
      "1a1b26"
      "f7768e"
      "9ece6a"
      "e0af68"
      "7aa2f7"
      "bb9af7"
      "7dcfff"
      "a9b1d6"
      "414868"
      "f7768e"
      "9ece6a"
      "e0af68"
      "7aa2f7"
      "bb9af7"
      "7dcfff"
      "c0caf5"
    ];
  };
  boot.kernelParams = [
    "quiet"
    "loglevel=3"
    "udev.log_level=3"
    "rd.udev.log_level=3"
  ];
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;

  # Also helps on Asahi
  boot.plymouth.enable = true; # optional, gives you a nice splash
}
