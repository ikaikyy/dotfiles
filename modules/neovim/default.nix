{ config, pkgs, ... }: {
  programs.nixvim = {
    enable = true;

    dependencies = { ripgrep.enable = true; };

    opts = {
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      relativenumber = true;
      clipboard = "unnamedplus";
      cmdheight = 0;
      termguicolors = true;
      signcolumn = "yes";
    };

    globals = {
      loaded_netrw = 1;
      loaded_netrwPlugin = 1;
      mapleader = " ";
    };

    colorschemes.gruvbox = {
      enable = true;
      settings = {
        contrast = "hard";
        transparent_mode = true;
      };
    };
    colorscheme = "gruvbox";
  };

  home.sessionVariables.EDITOR = "nvim";

  imports = [ ./auto-cmds.nix ./keymaps.nix ./plugins.nix ];
}
