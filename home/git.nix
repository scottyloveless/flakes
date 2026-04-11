{ ... };
{
    programs.git = {
      enable = true;
      userName = "Scotty Loveless";
      userEmail = "scottyloveless@icloud.com"
      extraConfig = {
          init.defaultBranch = "main";
          pull.rebase = true;
        };
      };
  }
