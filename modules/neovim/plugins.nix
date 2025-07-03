{ pkgs, config, ... }: {
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      settings = { highlight = { enable = true; }; };
    };

    lsp = {
      enable = true;
      servers = {
        clangd.enable = true;
        cssls.enable = true;
        eslint.enable = true;
        gopls.enable = true;
        html.enable = true;
        htmx.enable = true;
        jsonls.enable = true;
        lua_ls.enable = true;
        markdown_oxide.enable = true;
        nil_ls.enable = true;
        phan.enable = true;
        pylsp.enable = true;
        rust_analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
        };
        ts_ls.enable = true;
      };
    };

    lsp-format.enable = true;
    lsp-status.enable = true;

    alpha = {
      enable = true;

      theme.__raw = ''
        (function() 
          local dashboard = require("alpha.themes.dashboard")

          dashboard.section.buttons.val = {
            dashboard.button("n", "  New file", "<Cmd>ene!<CR>"),
            dashboard.button("e", "  Open file explorer", "<Cmd>NvimTreeToggle<CR>"),
            dashboard.button("d", "  Dotfiles", "<Cmd>NvimTreeOpen $HOME/dotfiles<CR>"),
            dashboard.button("q", "  Quit Neovim", "<Cmd>qa<CR>"),
          }

          dashboard.section.footer.val = "Welcome to Nixvim!";

          return dashboard.opts
        end)()
      '';
    };

    web-devicons.enable = true;

    nvim-tree = {
      enable = true;
      actions = { openFile = { quitOnOpen = true; }; };
      sortBy = "case_sensitive";
      view = { width = 40; };
      git = {
        enable = true;
        ignore = false;
      };
    };

    telescope = {
      enable = true;
      settings = {
        defaults = {
          prompt_prefix = "❯ ";
          selection_caret = "❯ ";
          mappings = {
            i = { "<esc>".__raw = ''require("telescope.actions").close''; };
          };
        };
      };
    };

    lualine = {
      enable = true;
      settings = {
        options = {
          icons_enabled = true;
          theme = "gruvbox";
          component_separators = {
            left = "";
            right = "";
          };
          section_separators = {
            left = "";
            right = "";
          };
          always_divide_middle = true;
          globalstatus = true;
          refresh = {
            statusline = 1000;
            tabline = 1000;
            winbar = 1000;
          };
        };
        sections = {
          lualine_a = [ "mode" ];
          lualine_b = [ "branch" "diff" "diagnostics" ];
          lualine_c = [ "filename" ];
          lualine_x = [ "copilot" "encoding" "filetype" ];
          lualine_y = [ "searchcount" ];
          lualine_z = [ "location" ];
        };
        inactive_sections = {
          lualine_c = [ "filename" ];
          lualine_x = [ "location" ];
        };
        extensions = [ "lazy" "mason" "nvim-tree" "trouble" ];

      };
    };

    none-ls = {
      enable = true;
      sources = {
        formatting = {
          black.enable = true;
          clang_format.enable = true;
          nixfmt.enable = true;
          prettierd = {
            enable = true;
            disableTsServerFormatter = true;
          };
          shfmt.enable = true;
          stylua.enable = true;
        };
      };
    };

    trouble.enable = true;

    coq-nvim = {
      enable = true;
      settings = { auto_start = true; };
    };

    markdown-preview.enable = true;

    copilot-lua = {
      enable = true;
      settings = {
        panel = {
          enabled = true;
          auto_refresh = false;
          keymap = {
            jump_prev = "[[";
            jump_next = "]]";
            accept = "<CR>";
            refresh = "gr";
            open = "<M-CR>";
          };
          layout = {
            position = "bottom";
            ratio = 0.4;
          };
        };
        filetypes = {
          gitcommit = false;
          gitrebase = false;
          hgcommit = false;
          svn = false;
          cvs = false;
          "." = false;
        };
        suggestion = {
          enabled = true;
          auto_trigger = true;
          hide_during_completion = false;
          debounce = 75;
          keymap = {
            accept = "<C-p>";
            accept_word = false;
            accept_line = false;
            next = "<C-]>";
            prev = "<C-[>";
            dismiss = "<esc>";
          };
        };
      };
    };
  };
}
