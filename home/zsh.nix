{ lib, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ls = "eza --color=always --icons=always --group-directories-first";
      ll = "eza -l --color=always --icons=always --group-directories-first";
      cat = "bat";
      cd = "z";
      y = "yazi";
    };
    completionInit = ''
      autoload -U compinit && compinit
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
    '';
    initContent = lib.mkMerge [
      (lib.mkBefore ''
        bindkey -e
        bindkey '^p' history-search-backward
        bindkey '^n' history-search-forward

        HISTSIZE=5000
        HISTFILE=~/.zsh_history
        SAVEHIST=$HISTSIZE
        HISTDUP=erase
        setopt appendhistory
        setopt sharehistory
        setopt hist_ignore_space
        setopt hist_ignore_all_dups
        setopt hist_save_no_dups
        setopt hist_ignore_dups
        setopt hist_find_no_dups

        vv() {
          local config=$(fd --max-depth 1 --glob 'nvim-*' ~/.config | fzf --prompt="Neovim Configs > " --height=~50% --layout=reverse --border --exit-0)
          [[ -z $config ]] && echo "No config selected" && return
          NVIM_APPNAME=$(basename $config) nvim $@
        }
      '')
      (lib.mkAfter ''
        # Source 1Password plugins last, after gh function is defined
        unalias gh 2>/dev/null
        unset -f gh 2>/dev/null
        if [ -f "$HOME/.config/op/plugins.sh" ]; then
          source "$HOME/.config/op/plugins.sh"
        fi
      '')
    ];
  };
}
