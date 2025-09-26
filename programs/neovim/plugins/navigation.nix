{...}: {
  programs.nixvim.dependencies.ripgrep.enable = true;
  programs.nixvim.plugins = {
    telescope = {
      enable = true;

      settings = {
        defaults = {
          prompt_prefix = "❯ ";
          selection_caret = "❯ ";
          path_display = ["truncate"];
          sorting_strategy = "ascending";
          file_ignore_patterns = [
            "%.git/"
            "node_modules/"
            "vendor/"
            "%.lock"
            "%.next/"
            "dist/"
            "build/"
            "target/"
            "%.cargo/"
          ];

          mappings = {
            i = {
              "<Tab>".__raw = "require('telescope.actions').move_selection_next";
              "<S-Tab>".__raw = "require('telescope.actions').move_selection_previous";
            };
            n = {
              "<Tab>".__raw = "require('telescope.actions').move_selection_next";
              "<S-Tab>".__raw = "require('telescope.actions').move_selection_previous";
            };
          };

          pickers = {
            buffers = {
              theme = "dropdown";
              previewer = false;
              initial_mode = "normal";
              mappings = {
                n = {
                  "dd".__raw = "require('telescope.actions').delete_buffer";
                };
              };
            };
          };
        };
      };
    };
  };

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>ff";
      action = "<cmd>Telescope find_files<cr>";
    }
    {
      mode = "n";
      key = "<leader>fg";
      action = "<cmd>Telescope live_grep<cr>";
    }
    {
      mode = "n";
      key = "<leader>fb";
      action = "<cmd>Telescope buffers<cr>";
    }
    {
      mode = "n";
      key = "<leader>fh";
      action = "<cmd>Telescope help_tags<cr>";
    }
  ];
}
