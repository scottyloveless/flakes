{ pkgs, lib, ... }:
let
  opsshsignPath =
    if pkgs.stdenv.isDarwin then
      "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"
    else
      "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
in
{
  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = false;
  };
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Scotty Loveless";
        email = "8176125+scottyloveless@users.noreply.github.com";
      };
      init.defaultBranch = "main";
      pull.rebase = true;
      gpg.format = "ssh";
      "gpg \"ssh\"".program = opsshsignPath;
      commit.gpgsign = true;
      user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMCL8BMJiFOVlj53eq1AEibxuEQ/XvgNCl4GZcbXne7Y";

      credential = {
        "https://github.com".helper = "!op plugin run -- gh auth git-credential";
        "https://gist.github.com".helper = "!op plugin run -- gh auth git-credential";
      };
    };
    ignores = [
      ".DS_Store"
      "*.swp"
      "result"
      ".env"
    ];
  };
}
