{...}: {
  programs.nixvim.plugins = {
    cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        sources = [
          {name = "copilot";}
          {name = "nvim_lsp";}
          {name = "path";}
          {name = "buffer";}
        ];

        mapping = {
          "<Tab>" = "cmp.mapping.select_next_item()";
          "<S-Tab>" = "cmp.mapping.select_prev_item()";
          "<C-j>" = "cmp.mapping.scroll_docs(4)";
          "<C-k>" = "cmp.mapping.scroll_docs(-4)";
          "<CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })";
          "<C-Space>" = ''
            cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.abort()
              else
                cmp.complete()
              end
            end, { "i", "s" })'';
        };

        experimental.ghost_text = true;
      };
    };
    copilot-cmp.enable = true;

    copilot-lua = {
      enable = true;
      settings = {
        panel.enabled = false;
        suggestion.enabled = false;
      };
    };
  };
}
