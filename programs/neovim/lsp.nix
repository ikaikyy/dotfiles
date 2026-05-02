{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      web-devicons.enable = true;

      lsp = {
        enable = true;

        servers = {
          bashls.enable = true;

          markdown_oxide.enable = true;

          html.enable = true;
          cssls.enable = true;

          ts_ls.enable = true;
          eslint.enable = true;
          jsonls.enable = true;

          intelephense = {
            enable = true;
            package = pkgs.intelephense;
          };

          lua_ls.enable = true;

          nil_ls.enable = true;
        };
      };

      lsp-status.enable = true;

      none-ls = {
        enable = true;

        sources = {
          formatting = {
            shfmt.enable = true;

            prettierd = {
              enable = true;
              disableTsServerFormatter = true;
            };
            rustywind.enable = true;

            pretty_php = {
              enable = true;
              package = pkgs.pretty-php;
            };
            blade_formatter = {
              enable = true;
              package = pkgs.blade-formatter;
              settings = {
                extra_args = [
                  "--wrap-attributes=force-expand-multiline"
                ];
              };
            };

            stylua.enable = true;

            alejandra.enable = true;

            ktlint.enable = true;
          };
        };
      };

      trouble = {
        enable = true;

        settings.keys = {
          "<esc>" = "cancel";
          "<cr>" = "jump_close";
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>td";
        action = "<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>";
      }
      {
        mode = "n";
        key = "<leader>tw";
        action = "<cmd>Trouble diagnostics toggle focus=true<cr>";
      }
    ];
  };
}
