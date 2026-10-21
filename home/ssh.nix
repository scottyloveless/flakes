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
    # Old home-manager defaults are spelled out below instead
    enableDefaultConfig = false;
    settings = {
      "*" = {
        AddKeysToAgent = "no";
        Compression = false;
        ControlMaster = "auto";
        ControlPath = "~/.ssh/sockets/%r@%h-%p";
        ControlPersist = "10m";
        ForwardAgent = false;
        HashKnownHosts = false;
        ServerAliveCountMax = 3;
        ServerAliveInterval = 60;
        UserKnownHostsFile = "~/.ssh/known_hosts";
        IdentitiesOnly = false;
        IdentityAgent = "\"${onePassPath}\"";
      };
    };
  };
}
