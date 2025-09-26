{...}: {
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;

      settings = {
        highlight.enable = true;
        folding.enable = true;
      };
    };
  };
}
