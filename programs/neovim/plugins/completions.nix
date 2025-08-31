{...}: {
  programs.nixvim.plugins = {
    blink-cmp = {
      enable = true;
      setupLspCapabilities = true;

      settings = {
        sources = {
          default = [
            "lsp"
            "path"
            "buffer"
            "copilot"
          ];

          providers.copilot = {
            async = true;
            module = "blink-cmp-copilot";
            name = "copilot";
            score_offset = 100;
          };
        };

        completion = {
          list.selection.preselect = false;
          documentation.auto_show = true;
          documentation.auto_show_delay_ms = 50;
        };

        keymap = {
          "<C-space>" = [
            "show_documentation"
            "hide_documentation"
            "fallback"
          ];
          "<C-e>" = [
            "show"
            "hide"
            "fallback"
          ];
          "<CR>" = [
            "accept"
            "fallback"
          ];

          "<Tab>" = [
            "select_next"
            "fallback"
          ];
          "<S-Tab>" = [
            "select_prev"
            "fallback"
          ];

          "<C-j>" = [
            "scroll_documentation_down"
            "fallback"
          ];
          "<C-k>" = [
            "scroll_documentation_up"
            "fallback"
          ];
        };
      };
    };
    blink-cmp-copilot.enable = true;

    copilot-lua = {
      enable = true;
      settings = {
        panel.enabled = false;
        suggestion.enabled = false;
      };
    };
  };
}
