{ pkgs, ... }:
let
  onePassPath =
    if pkgs.stdenv.isDarwin then
      "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    else
      "~/.1password/agent.sock";
in
{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "*" = {
        forwardAgent = false;
        serverAliveInterval = 60;
        controlMaster = "auto";
        controlPath = "~/.ssh/sockets/%r@%h-%p";
        controlPersist = "10m";
        extraOptions = {
          "IdentitiesOnly" = "no";
          "IdentityAgent" = "\"${onePassPath}\"";
        };
      };
    };
  };
}
