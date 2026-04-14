{ pkgs, ... }:
{
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.systemPackages = with pkgs; [
    git
    curl
    wget
  ];

  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    font-awesome_4
  ];

  programs.zsh.enable = true;

  environment.shells = with pkgs; [ zsh ];

  system.stateVersion = "25.11";

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "mox" ];
  };

}
