{ ... }:
{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        font = "JetBrainsMono Nerd Font 11";
        width = 340;
        height = 120;
        offset = "12x36";
        origin = "top-right";
        padding = 10;
        horizontal_padding = 12;
        frame_width = 1;
        frame_color = "#414868";
        corner_radius = 6;
        separator_color = "frame";
        line_height = 2;
        markup = "full";
        format = "<b>%s</b>\\n%b";
        alignment = "left";
        icon_position = "left";
        min_icon_size = 0;
        max_icon_size = 32;
      };

      urgency_low = {
        background = "#1a1b26";
        foreground = "#a9b1d6";
        timeout = 4;
      };

      urgency_normal = {
        background = "#1a1b26";
        foreground = "#c0caf5";
        timeout = 6;
      };

      urgency_critical = {
        background = "#1a1b26";
        foreground = "#f7768e";
        frame_color = "#f7768e";
        timeout = 0;
      };
    };
  };
}
