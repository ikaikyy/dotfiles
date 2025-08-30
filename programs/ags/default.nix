{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [inputs.ags.homeManagerModules.default];

  programs.ags = {
    enable = true;

    configDir = ./config;

    extraPackages = [
      inputs.astal.packages.${pkgs.system}.apps
      inputs.astal.packages.${pkgs.system}.hyprland
      inputs.astal.packages.${pkgs.system}.tray
    ];
  };

  wayland.windowManager.hyprland.settings = {
    exec-once = ["ags run --gtk 4"];
    bind = ["$mod, M, exec, ags request 'toggle-app-launcher'"];
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
