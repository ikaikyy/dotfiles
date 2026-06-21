{
  config,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [ rofi rofi-power-menu ];
  xdg.configFile."rofi/opencode.rasi".source = ./opencode.rasi;
  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
}
