{ pkgs, config, ... }:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    font = "JetBrainsMono Nerd Font 12";
    terminal = "ghostty";
    theme =
      let
        inherit (config.lib.formats.rasi) mkLiteral;
      in
      {
        "*" = {
          bg = mkLiteral "#1a1b26";
          bg-alt = mkLiteral "#16161e";
          fg = mkLiteral "#c0caf5";
          accent = mkLiteral "#7aa2f7";
          border = mkLiteral "#414868";
          muted = mkLiteral "#565f89";

          background-color = mkLiteral "@bg";
          text-color = mkLiteral "@fg";
        };

        "window" = {
          width = mkLiteral "500px";
          border = mkLiteral "1px";
          border-color = mkLiteral "@border";
          border-radius = mkLiteral "6px";
          padding = mkLiteral "12px";
        };

        "inputbar" = {
          children = map mkLiteral [
            "prompt"
            "entry"
          ];
          padding = mkLiteral "0 0 10px 0";
        };

        "prompt" = {
          text-color = mkLiteral "@accent";
          padding = mkLiteral "0 8px 0 0";
        };

        "entry" = {
          placeholder = "search...";
          placeholder-color = mkLiteral "@muted";
        };

        "listview" = {
          lines = 8;
          spacing = mkLiteral "2px";
        };

        "element" = {
          padding = mkLiteral "6px 10px";
          border-radius = mkLiteral "4px";
        };

        "element selected" = {
          background-color = mkLiteral "@bg-alt";
          text-color = mkLiteral "@accent";
        };

        "element-text" = {
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "inherit";
        };
      };
  };
}
