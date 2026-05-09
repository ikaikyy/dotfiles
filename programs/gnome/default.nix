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
        disable-topbar-styling = true;
        horizontal-margin = 0;
        vertical-margin = 0;
        vertical-margin-bottom = 0;
        window-gap = 0;
        selection-border-size = 0;
        show-focus-mode-icon = false;
        show-open-position-icon = false;
        show-window-position-bar = false;
        show-workspace-indicator = false;
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
      "org/gnome/shell/extensions/vertical-workspaces" = {
        center-app-grid = true;
        center-dash-to-ws = true;
        dash-isolate-workspaces = false;
        dash-position = 3;
        dash-position-adjust = 0;
        overview-mode = 0;
        show-app-icon-position = 0;
        show-ws-preview-bg = true;
        show-ws-switcher-bg = true;
        show-wst-labels = 0;
        show-wst-labels-on-hover = false;
        workspace-animation-module = false;
        workspace-module = true;
        workspace-switcher-animation = 0;
        workspace-switcher-popup-module = false;
        ws-preview-bg-radius = 30;
        ws-preview-scale = 95;
        ws-switcher-wraparound = false;
        ws-thumbnails-full = true;
        ws-thumbnails-position = 1;
      };
    };
  };
}
