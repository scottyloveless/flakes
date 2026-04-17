{ ... }:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        grace = 0;
        disable_loading_bar = true;
      };

      background = [
        {
          color = "rgba(1a1b26ff)";
        }
      ];

      input-field = [
        {
          size = "280, 40";
          position = "0, -60";
          halign = "center";
          valign = "center";
          outline_thickness = 1;
          dots_size = 0.2;
          dots_spacing = 0.3;
          font_family = "JetBrainsMono Nerd Font";
          font_color = "rgba(c0caf5ff)";
          inner_color = "rgba(16161eff)";
          outer_color = "rgba(414868ff)";
          check_color = "rgba(9ece6aff)";
          fail_color = "rgba(f7768eff)";
          fade_on_empty = false;
          placeholder_text = "password";
          hide_input = false;
          rounding = 4;
        }
      ];

      label = [
        {
          text = "cmd[update:1000] date +\"%H:%M\"";
          color = "rgba(7aa2f7ff)";
          font_size = 72;
          font_family = "JetBrainsMono Nerd Font";
          position = "0, 80";
          halign = "center";
          valign = "center";
        }
        {
          text = "cmd[update:60000] date +\"%A, %B %d\"";
          color = "rgba(a9b1d6ff)";
          font_size = 16;
          font_family = "JetBrainsMono Nerd Font";
          position = "0, 20";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
