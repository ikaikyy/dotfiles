{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [wl-clipboard clipse];

  wayland.windowManager.hyprland.settings = {
    exec-once = ["clipse -listen"];

    windowrule = [
      "float, class:(clipse)"
      "size 1000 800, class:(clipse)"
      "stayfocused, class:(clipse)"
    ];

    bind = ["$mod, V, exec, wezterm -e --class clipse clipse"];
  };
}
