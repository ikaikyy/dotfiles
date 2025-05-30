{ inputs, config, pkgs, ... }: {
  imports = [ inputs.ags.homeManagerModules.default ];

  home.packages = with pkgs; [ dart-sass ];

  programs.ags = {
    enable = true;

    configDir = ./config;

    extraPackages = [
      inputs.ags.packages.${pkgs.system}.apps
      inputs.ags.packages.${pkgs.system}.hyprland
    ];
  };

  wayland.windowManager.hyprland.settings = {
    exec-once = [ "ags run --gtk4" ];
    bind = [ "$mod, M, exec, ags request 'toggle-app-launcher'" ];
    layerrule = [ "blur, AppLauncher" "blur, Bar" ];
  };
}
