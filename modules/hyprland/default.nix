{ config, pkgs, ... }: {
  home.packages = with pkgs; [ qt6.full ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    systemd.enable = false;
    xwayland.enable = true;

    settings = {
      "$mod" = "SUPER";

      monitor = ",2560x1440@165,auto,auto";

      input = {
        kb_layout = "us, br";
        kb_options = "grp:win_space_toggle";

        follow_mouse = 1;

        touchpad = { natural_scroll = "no"; };

        accel_profile = "flat";
        numlock_by_default = true;
        sensitivity = -0.5;
      };

      bind = [
        "CTRL ALT, T, exec, kitty"
        "$mod, Q, killactive, "
        "$mod, F, fullscreen,"
        "$mod, E, exec, nautilus"
        "$mod, Z, togglefloating, "
        "$mod, P, pseudo,"
        "$mod, R, togglesplit,"
        "$mod, M, exec, pkill rofi || rofi -show drun"
        "$mod, L, exec, hyprlock"

        # Printscreen
        ", Print, exec, printscreen"

        # Move focus with mod+ hjkl
        "$mod, H, movefocus, l"
        "$mod, J, movefocus, d"
        "$mod, K, movefocus, u"
        "$mod, L, movefocus, r"

        # Switch between workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"

        # Move active window to workspace
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"

        # Audio controls
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle"

        # Scroll through existing workspaces with mod+ scroll
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"

      ];
      bindm = [ "$mod, mouse:272, movewindow" "$mod, mouse:273, resizewindow" ];
    };
  };
}
