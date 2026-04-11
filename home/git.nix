{ ... }:
{
    programs.git = {
      enable = true;
      settings = {
        user.email = "scottyloveless@icloud.com"
        user.name = "Scotty Loveless"
        init.defaultBranch = "main";
        pull.rebase = true;
        };
      };
  }
