{ ... }:
{
    programs.zsh = {
        enable = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        shellAliases = {
            ll = "eza -l";
            cat = "bat";
          };
          initContent = ''

          '';
      };
  }
