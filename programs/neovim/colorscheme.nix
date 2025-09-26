{...}: {
  programs.nixvim.colorschemes.gruvbox = {
    enable = true;

    settings = {
      contrast = "hard";
    };
  };

  programs.nixvim.colorscheme = "gruvbox";
}
