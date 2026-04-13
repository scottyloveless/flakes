{ pkgs, lib, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user.email = "scottyloveless@icloud.com";
      user.name = "Scotty Loveless";
      init.defaultBranch = "main";
      pull.rebase = true;
    };
    extraConfig = {
      gpg.format = "ssh";
      "gpg \"ssh\"".program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
      commit.gpgsign = true;
    };
  };
}
