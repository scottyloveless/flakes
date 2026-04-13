{ pkgs, lib, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user.email = "8176125+scottyloveless@users.noreply.github.com";
      user.name = "scottyloveless";
      init.defaultBranch = "main";
      pull.rebase = true;
      gpg.format = "ssh";
      "gpg \"ssh\"".program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
      commit.gpgsign = true;
      user.signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPk7r3TG9FVIfnZffcmLCN/r4gpuWdcd2oUWDd7/7J1Q";
    };
  };
}
