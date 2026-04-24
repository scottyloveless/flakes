{ pkgs, ... }:
{
  programs.lazyvim = {
    enable = true;

    installCoreDependencies = true;

    config = {
      options = ''
                -- Options are automatically loaded before lazy.nvim startup
        -- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
        -- Add any additional options here
        vim.g.snacks_animate = false

        ----- undo -----
        vim.o.undofile = true

        vim.o.tabstop = 4
        vim.o.shiftwidth = 4
        vim.o.softtabstop = 4
        vim.o.expandtab = true

        local undodir = vim.fn.expand("~/.vim/undo")
        if vim.fn.isdirectory(undodir) == 0 then
          vim.fn.mkdir(undodir, "p")
        end
        vim.opt.undodir = undodir

        vim.o.scrolloff = 10

        vim.o.iskeyword = "@,48-57,_,192-255,-" -- Treat dash as `word` textobject part, default "@,48-57,_,192-255"

        -- -- clipboard --
        -- vim.schedule(function()
        --   vim.o.clipboard = "unnamedplus"
        -- end)

        -- performance --
        -- disable some default providers
        vim.g.loaded_node_provider = 0
        vim.g.loaded_python3_provider = 0
        vim.g.loaded_perl_provider = 0
        vim.g.loaded_ruby_provider = 0
      '';
    };

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

      snacks = ''
                          return {
                            "folke/snacks.nvim",
                            opts = {
                              explorer = {
                                enabled = true,
                                replace_netrw = true,
                              },
                              picker = {
                                sources = {
                                  explorer = {
                                    layout = {
                                      preset = "sidebar",
                                      layout = {
                                        width = 30,
                                      },
                                    },
                                  },
                                },
                              },
                              dashboard = {
                                enabled = true,
                                preset = {
                                  header = [[
        	                                                                       
        	                                                                     
        	       ████ ██████           █████      ██                     
        	      ███████████             █████                             
        	      █████████ ███████████████████ ███   ███████████   
        	     █████████  ███    █████████████ █████ ██████████████   
        	    █████████ ██████████ █████████ █████ █████ ████ █████   
        	  ███████████ ███    ███ █████████ █████ █████ ████ █████  
        	 ██████  █████████████████████ ████ █████ █████ ████ ██████ 
        	                                                                       
                                  ]],
                                },
                              },
                            },
                          }
      '';

      nvim-lspconfig = ''
        return {
          "neovim/nvim-lspconfig",
          opts = {
            inlay_hints = { enabled = false },
          },
        }
      '';

      blink-cmp = ''
        return {
          {
            "saghen/blink.cmp",
            opts = {
              keymap = {
                -- This disables <CR> (Enter) for completion
                ["<CR>"] = { "fallback" },
              },
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
      lang.sql.enable = true;
      lang.markdown.enable = true;
      lang.json.enable = true;
      lang.toml.enable = true;
    };
  };
}
