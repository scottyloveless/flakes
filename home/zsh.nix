{ ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "eza -l";
      cat = "bat";
    };
    initContent = ''
        bindkey -e
        bindkey '^p' history-search-backward
        bindkey '^n' history-search-forward

        #History
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
        # Assumes all configs exist in directories named ~/.config/nvim-*
        local config=$(fd --max-depth 1 --glob 'nvim-*' ~/.config | fzf --prompt="Neovim Configs > " --height=~50% --layout=reverse --border --exit-0)
       
        # If I exit fzf without selecting a config, don't open Neovim
        [[ -z $config ]] && echo "No config selected" && return
       
        # Open Neovim with the selected config
        NVIM_APPNAME=$(basename $config) nvim $@
      }

    '';
  };
}
