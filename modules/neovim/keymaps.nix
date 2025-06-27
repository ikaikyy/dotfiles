{ pkgs, config, ... }: {
  programs.nixvim.keymaps = [
    # Save buffer
    {
      key = "<leader>sv";
      action = "<Cmd>w<CR>";
      mode = "n";
    }
    # Clear current search
    {
      key = "<esc>";
      action = "<Cmd>noh<CR>";
      mode = "n";
    }
    # NvimTree
    {
      key = "<leader>pv";
      action = "<Cmd>NvimTreeToggle<CR>";
      mode = "n";
      options = {
        noremap = true;
        silent = true;
      };
    }
    # Formatter
    {
      key = "<leader>fmt";
      action.__raw = ''
        function()
          vim.lsp.buf.format({ async = false })
        end
      '';
      mode = [ "n" "v" ];
    }
    # Trouble
    {
      key = "<leader>td";
      action = "<Cmd>Trouble diagnostics toggle focus=true filter.buf=0<CR>";
      mode = "n";
    }
    {
      key = "<leader>tD";
      action = "<Cmd>Trouble diagnostics toggle focus=true<CR>";
      mode = "n";
    }
    # Telescope
    {
      key = "<leader>ff";
      action = "<Cmd>Telescope find_files<CR>";
      mode = "n";
    }
    {
      key = "<leader>fg";
      action = "<Cmd>Telescope live_grep<CR>";
      mode = "n";
    }
  ];
}
