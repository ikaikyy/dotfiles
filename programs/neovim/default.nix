{
  config,
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./autocmd.nix
    ./colorscheme.nix
    ./keymaps.nix
    ./lsp.nix
    ./plugins
  ];

  programs.nixvim = {
    enable = true;
    enableMan = true;
    enablePrintInit = true;

    defaultEditor = true;

    opts = {
      # Basic editing
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      autoindent = true;
      smartindent = true;

      # Line numbers
      number = true;
      relativenumber = true;

      # Search
      hlsearch = true;
      incsearch = true;
      ignorecase = true;
      smartcase = true;

      # Visual
      termguicolors = true;
      signcolumn = "yes";
      cursorline = true;
      cmdheight = 0;
      scrolloff = 8;
      sidescrolloff = 8;
      wrap = false;

      # Clipboard
      clipboard = "unnamedplus";

      # Undo
      undofile = true;
      undodir = "/home/kaiky/.vim/undodir";
    };

    globals = {
      # Disable netrw
      loaded_netrw = 1;
      loaded_netrwPlugin = 1;

      mapleader = " ";
    };
  };
}
