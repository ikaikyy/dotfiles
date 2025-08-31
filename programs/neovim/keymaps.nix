{ ... }:
{
  programs.nixvim.keymaps = [
    # Save buffer
    {
      mode = "n";
      key = "<leader>sv";
      action = "<cmd>w<CR>";
    }
    # Clear search highlight
    {
      mode = "n";
      key = "<esc>";
      action = "<cmd>noh<CR>";
    }
    # Formatting
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>fmt";
      action.__raw = "function() vim.lsp.buf.format({ async = false }) end";
    }
  ];
}
