{...}: {
  programs.nixvim.plugins = {
    lazygit.enable = true;
    gitsigns.enable = true;
  };

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>lg";
      action = "<cmd>LazyGit<cr>";
    }
  ];
}
