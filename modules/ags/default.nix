{ inputs, config, pkgs, ... }: {
  imports = [ inputs.ags.homeManagerModules.default ];

  home.packages = with pkgs; [ dart-sass ];

  programs.ags = { enable = true; };
}
