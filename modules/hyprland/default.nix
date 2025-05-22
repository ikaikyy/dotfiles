{ config, pkgs, hostName, ... }: {
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

      general = {
        gaps_out = 12;
        border_size = 0;

        layout = "dwindle";

        allow_tearing = false;
      };

      decoration = {
        rounding = 12;

        blur = {
          enabled = true;
          size = 5;
          passes = 2;
        };

      };

      animations = {
        enabled = "yes";

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };

      gestures = { workspace_swipe = "off"; };

      bind = [
        "CTRL ALT, T, exec, kitty"
        "$mod, Q, killactive, "
        "$mod, F, fullscreen,"
        "$mod, E, exec, nautilus"
        "$mod, Z, togglefloating, "
        "$mod, P, pseudo,"
        "$mod, R, togglesplit,"
        "$mod, L, exec, hyprlock"

        # Printscreen
        ", Print, exec, printscreen"

        # Move focus with alt + hjkl
        "ALT, H, movefocus, l"
        "ALT, J, movefocus, d"
        "ALT, K, movefocus, u"
        "ALT, L, movefocus, r"

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

  programs.hyprlock = {
    enable = true;
    settings = {
      general = { hide_cursor = true; };

      background = [{
        path = "screenshot";
        blur_passes = 3;
        blur_size = 8;
      }];

      input-field = [{
        size = "386, 64";
        position = if (hostName == "desktop") then "0, -386" else "0, -256";
        dots_center = true;
        dots_spacing = 0.5;
        inner_color = "rgb(49, 50, 68)";
        outer_color = "rgb(203, 166, 247)";

        font_family = "JetBrains Mono";
        font_color = "rgb(205, 214, 244)";
        placeholder_text = "<b>Password...</b>";
      }];
    };
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "~/dotfiles/images/wallpapers/may-and-latios.jpg" ];
      wallpaper = [ ",~/dotfiles/images/wallpapers/may-and-latios.jpg" ];
    };
  };
}
