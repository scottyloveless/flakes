{ ... }:
{
  programs.ghostty = {
    enable = true;
    package = if pkgs.stdenv.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;

    settings = {
      shell-integration = "zsh";
      mouse-hide-while-typing = true;
      scrollback-limit = 100000;
      cursor-style = "block";
      shell-integration-features = "no-cursor";
      font-family = "JetBrainsMono Nerd Font";
      font-size = 13;
      font-thicken = true;
      clipboard-trim-trailing-spaces = true;
      theme = "TokyoNight Night";
      window-decoration = false;
      background = "1a1b26";
      window-padding-x = 12;
      window-padding-y = 12;
      window-padding-color = "background";
      quit-after-last-window-closed = true;
      async-backend = "epoll";
    };
  };
}
