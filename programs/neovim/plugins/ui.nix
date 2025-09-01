{...}: {
  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>pv";
      action = "<cmd>NvimTreeToggle<cr>";
    }
  ];

  programs.nixvim.plugins = {
    alpha = {
      enable = true;

      theme.__raw = ''
        (function()
          local dashboard = require("alpha.themes.dashboard")

          dashboard.section.buttons.val = {
            dashboard.button("n", "󰻭 New file", "<Cmd>ene!<CR>"),
            dashboard.button("e", "󰉖 Open file explorer", "<Cmd>NvimTreeToggle<CR>"),
            dashboard.button("f", "󰱽 Find file", "<cmd>Telescope find_files<CR>"),
            dashboard.button("r", "󱋢 Recent files", "<cmd>Telescope oldfiles<CR>"),
            dashboard.button("g", "󱎸 Live grep", "<cmd>Telescope live_grep<CR>"),
            dashboard.button("d", "󱂀 Dotfiles", "<Cmd>NvimTreeOpen $HOME/dotfiles<CR>"),
            dashboard.button("q", "󰿅 Quit Neovim", "<Cmd>qa<CR>"),
          }

          dashboard.section.footer.val = "Welcome to Nixvim!";

          return dashboard.opts
        end)()
      '';
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
          disabled_filetypes = {
            statusline = [
              "alpha"
              "dashboard"
            ];
          };
          always_divide_middle = true;
          globalstatus = true;
        };
        sections = {
          lualine_a = ["mode"];
          lualine_b = [
            "branch"
            "diff"
            "diagnostics"
          ];
          lualine_c = ["filename"];
          lualine_x = [
            "copilot"
            "encoding"
            "filetype"
          ];
          lualine_y = ["searchcount"];
          lualine_z = ["location"];
        };
        inactive_sections = {
          lualine_a = [];
          lualine_b = [];
          lualine_c = ["filename"];
          lualine_x = ["location"];
          lualine_y = [];
          lualine_z = [];
        };
        extensions = [
          "nvim-tree"
          "trouble"
          "quickfix"
        ];
      };
    };

    nvim-tree = {
      enable = true;

      settings = {
        sort = {
          sorter = "case_sensitive";
        };
        view = {
          width = 40;
          side = "left";
        };
        renderer = {
          group_empty = false;
        };
        git = {
          enable = true;
          ignore = false;
        };
        actions = {
          open_file = {
            quit_on_open = true;
          };
        };
        diagnostics = {
          enable = true;
          show_on_dirs = true;
        };
      };
    };

    gitsigns.enable = true;

    notify.enable = true;
  };
}
