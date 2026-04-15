{ inputs, pkgs, ... }:
{
  imports = [ inputs._1password-shell-plugins.hmModules.default ];
  programs._1password-shell-plugins = {
    enable = true;
    plugins = with pkgs; [
      gh
      cachix
    ];
  };

  xdg.configFile."1Password/ssh/agent.toml".text = ''
    # Order of vaults to search for keys
    [[ssh-keys]]
    vault = "Private"
  '';
}
