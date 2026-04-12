{ pkgs, ... }:
{
  programs.lazyvim = {
    enable = true;

    installCoreDependencies = true;

    plugins = {
      colorscheme = ''
                return {
          -- { "EdenEast/nightfox.nvim" },

          {
            "LazyVim/LazyVim",
            opts = {
              colorscheme = "tokyonight-night",
            },
          },
        }
      '';
    };

    extras = {
      lang.nix.enable = true;
      lang.go = {
        enable = true;
        installDependencies = true;
        installRuntimeDependencies = true;
      };
    };
  };
}
