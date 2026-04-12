{ config, pkgs, ... }:

{
  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true; # Change to enableBashIntegration or enableFishIntegration if needed
    settings = {
      schema = "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json";
      version = 4;
      final_space = true;
      console_title_template = "{{ .Shell }} in {{ .Folder }}";
      accent_color = "#86e1fc";

      upgrade = {
        source = "cdn";
        interval = "168h";
        auto = false;
        notice = false;
      };

      blocks = [
        {
          type = "prompt";
          alignment = "left";
          newline = true;
          segments = [
            {
              type = "os";
              style = "plain";
              foreground = "#86e1fc";
              background = "transparent";
              template = "{{ .Icon }}  ";
            }
            {
              type = "path";
              style = "plain";
              foreground = "#7aa2f7";
              background = "transparent";
              template = "{{ .Path }}";
              properties = {
                style = "full";
              };
            }
            {
              type = "git";
              style = "plain";
              foreground = "#9ece6a";
              background = "transparent";
              foreground_templates = [
                "{{ if or (.Working.Changed) (.Staging.Changed) }}#ff9e64{{ end }}"
                "{{ if and (gt .Ahead 0) (gt .Behind 0) }}#FFCC80{{ end }}"
                "{{ if gt .Ahead 0 }}#B388FF{{ end }}"
                "{{ if gt .Behind 0 }}#B388FB{{ end }}"
              ];
              template = " {{ if or (.Working.Changed) (.Staging.Changed) }}*{{ end }} <cyan>{{ if gt .Behind 0 }}⇣{{ end }}{{ if gt .Ahead 0 }}⇡{{ end }}</>";
              # Properties/Options were split in your TOML; Nix keeps them in the segment set
              fetch_status = true;
              fetch_upstream_icon = false;
              display_status = true;
              # branch_icon = " ";
              source = "cli";
            }
          ];
        }
        {
          type = "rprompt";
          overflow = "hidden";
          segments = [
            {
              type = "python";
              style = "powerline";
              display_mode = "environment";
              foreground = "magenta";
              background = "transparent";
              template = "{{ if .Error }}{{ .Error }}{{ else }}{{ if .Venv }}{{ .Venv }} {{ end }}{{ .Full }}{{ end }}  ";
            }
            {
              type = "executiontime";
              style = "plain";
              foreground = "yellow";
              background = "transparent";
              template = "{{ .FormattedMs }}";
              properties = {
                threshold = 5000;
              };
            }
          ];
        }
        {
          type = "prompt";
          alignment = "left";
          newline = true;
          segments = [
            {
              type = "text";
              style = "plain";
              foreground_templates = [
                "{{if gt .Code 0}}red{{end}}"
                "{{if eq .Code 0}}magenta{{end}}"
              ];
              background = "transparent";
              template = "❯";
            }
          ];
        }
      ];

      transient_prompt = {
        foreground_templates = [
          "{{if gt .Code 0}}red{{end}}"
          "{{if eq .Code 0}}magenta{{end}}"
        ];
        background = "transparent";
        template = "❯ ";
      };

      secondary_prompt = {
        foreground = "magenta";
        background = "transparent";
        template = "❯❯ ";
      };
    };
  };
}
