{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [ inputs.ags.homeManagerModules.default ];

  programs.ags = {
    enable = true;

    configDir = ./config;

    extraPackages = [
      inputs.ags.packages.${pkgs.system}.apps
      inputs.ags.packages.${pkgs.system}.hyprland
      inputs.ags.packages.${pkgs.system}.tray
    ];
  };

  wayland.windowManager.hyprland.settings = {
    exec-once = [ "ags run --gtk4" ];
    bind = [ "$mod, M, exec, ags request 'toggle-app-launcher'" ];
    layerrule =
      builtins.concatMap
        (s: [
          "blur, ${s}"
          "blurpopups, ${s}"
          "ignorezero, ${s}"
        ])
        [
          "AppLauncher"
          "Bar"
        ];
  };
}
