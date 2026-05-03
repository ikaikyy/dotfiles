{ pkgs, ... }:
{
  imports = [ ./keybinds.nix ];

  home.packages = with pkgs; [
    gnomeExtensions.brightness-control-using-ddcutil
    gnomeExtensions.paperwm
    gnomeExtensions.vertical-workspaces
  ];

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/wm/preferences" = {
        num-workspaces = 9;
      };
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        clock-show-date = true;
        clock-show-weekday = true;
        enable-hot-corners = false;
      };
      "org/gnome/desktop/peripherals/mouse" = {
        accel-profile = "flat";
        speed = -0.5;
      };
      "org/gnome/shell/app-switcher" = {
        current-workspace-only = true;
      };
      "org/gnome/shell" = {
        enabled-extensions = [
          "display-brightness-ddcutil@themightydeity.github.com"
          "paperwm@paperwm.github.com"
          "vertical-workspaces@G-dH.github.com"
        ];
      };
      "org/gnome/shell/extensions/paperwm" = {
        default-focus-mode = 0;
        horizontal-margin = 0;
        vertical-margin = 0;
        vertical-margin-bottom = 0;
        window-gap = 0;
        selection-border-size = 0;
      };
      "org/gnome/shell/extensions/paperwm/keybindings" = {
        switch-left = [ "<Super>h" ];
        switch-down = [ "<Super>j" ];
        switch-up = [ "<Super>k" ];
        switch-right = [ "<Super>l" ];
        switch-down-workspace = [ "<Super><Control>j" ];
        switch-up-workspace = [ "<Super><Control>k" ];
        move-down-workspace = [ "<Super><Shift><Control>j" ];
        move-up-workspace = [ "<Super><Shift><Control>k" ];
      };
    };
  };
}
