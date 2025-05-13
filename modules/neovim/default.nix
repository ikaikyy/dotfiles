{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    nodePackages.nodejs
    go
    cargo
    gcc

    ripgrep
  ];

  xdg.configFile.nvim.source = ./config;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  home.sessionVariables.EDITOR = "nvim";
}
