{
  pkgs,
  ...
}:
let
  mod = "SUPER";
in
{
  imports = [
    ../cliphist
    ../dunst
    ../rofi
    ../desktop
    ../hyprlock
    (import ../waybar {
      modules-left = [ "hyprland/workspaces" ];
      modules-center = [ "hyprland/window" ];
      language-module = "hyprland/language";
      extra-settings = {
        "hyprland/workspaces" = {
          all-outputs = false;
          format = "{icon}";
          format-icons = { active = " "; default = " "; persistent = " "; };
          persistent_workspaces."*" = 9;
        };
        "hyprland/window" = {
          format = "{title}";
          max-length = 80;
          separate-outputs = false;
        };
        "hyprland/language" = {
          format = "{shortDescription}";
          tooltip = true;
          tooltip-format = "{shortDescription} - {longDescription}";
          on-click = "hyprctl switchxkblayout all next";
        };
      };
    })
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    configType = "hyprlang";
    plugins = [ pkgs.hyprlandPlugins.hyprspace ];
    settings = {
      "$mainMod" = mod;

      monitor = [ ",3440x1440@180,auto,1" ];

      env = [
        "XKB_DEFAULT_LAYOUT,us,br"
        "XKB_DEFAULT_OPTIONS,grp:win_space_toggle"
      ];

      general = {
        layout = "scrolling";
        gaps_in = 0;
        gaps_out = 0;
        border_size = 1;
        "col.active_border" = "rgb(fab283)";
        "col.inactive_border" = "rgb(1a1a1a)";
      };

      scrolling = {
        fullscreen_on_one_column = true;
        column_width = 0.5;
        direction = "right";
        focus_fit_method = 1;
        wrap_focus = true;
        wrap_swapcol = true;
      };

      input = {
        kb_layout = "us,br";
        kb_variant = ",";
        kb_options = "grp:win_space_toggle";
        follow_mouse = 1;
        mouse_refocus = false;
        accel_profile = "flat";
        sensitivity = -0.5;
        repeat_rate = 30;
        repeat_delay = 300;
        touchpad = {
          natural_scroll = true;
          "tap-to-click" = true;
        };
      };

      workspace = [
        "1, default:true, persistent:true"
      ] ++ builtins.genList (i: "${toString (i + 2)}, persistent:true") 8;

      bind = [
        "$mainMod, H, layoutmsg, focus l"
        "$mainMod, L, layoutmsg, focus r"
        "$mainMod, J, layoutmsg, focus d"
        "$mainMod, K, layoutmsg, focus u"

        "$mainMod SHIFT, H, layoutmsg, swapcol l"
        "$mainMod SHIFT, L, layoutmsg, swapcol r"
        "$mainMod SHIFT, J, movewindow, d"
        "$mainMod SHIFT, K, movewindow, u"

        "$mainMod CTRL, H, layoutmsg, colresize -0.05"
        "$mainMod CTRL, L, layoutmsg, colresize +0.05"

        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"

        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"

        "$mainMod, Q, killactive,"
        "$mainMod, F, fullscreen, 1"
        "$mainMod, M, fullscreenstate, -1 2"
        "$mainMod, V, togglefloating,"

        "$mainMod, O, overview:toggle"

        "$mainMod ALT, L, exec, hyprlock"
        "CTRL ALT, T, exec, ghostty"

        "$mainMod, D, exec, rofi -show drun -show-icons -theme opencode"
        "$mainMod, R, exec, rofi -show drun -show-icons -theme opencode"
        "$mainMod, TAB, exec, rofi -show window -show-icons -theme opencode"

        "$mainMod SHIFT, E, exec, rofi -show p -modi p:rofi-power-menu -theme opencode"

        ",Print, exec, grim - | wl-copy"
        "CTRL, Print, exec, grim -g \"$(slurp)\" - | wl-copy"
        "$mainMod SHIFT, S, exec, grim -g \"$(slurp)\" - | wl-copy"

        "$mainMod SHIFT, V, exec, sh -c 'cliphist list | rofi -dmenu -display-columns 2 -theme opencode | cliphist decode | wl-copy'"

        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

        ",XF86MonBrightnessUp, exec, brightnessctl set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"

        ",XF86AudioPlay, exec, playerctl play-pause"
        ",XF86AudioPause, exec, playerctl pause"
        ",XF86AudioNext, exec, playerctl next"
        ",XF86AudioPrev, exec, playerctl previous"

        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      exec-once = [
        "hyprpaper"
        "waybar"
        "dunst"
        "/run/current-system/sw/libexec/polkit-gnome-authentication-agent-1"
      ];

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        force_default_wallpaper = 0;
        vrr = 1;
      };

      decoration = {
        rounding = 4;
        blur.enabled = true;
        blur.size = 4;
        blur.passes = 2;
      };

      debug.vfr = true;
      cursor.no_hardware_cursors = false;
    };
  };

  home.packages = with pkgs; [ hyprpaper ];

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
      };
      listener = [
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 600;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "/home/ikaikyy/dotfiles/images/wallpapers/vestrahorn-iceland.webp" ];
      wallpaper = [ ",/home/ikaikyy/dotfiles/images/wallpapers/vestrahorn-iceland.webp" ];
    };
  };
}
