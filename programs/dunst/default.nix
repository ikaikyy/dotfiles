{ pkgs, ... }:
{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        monitor = 0;
        follow = "mouse";
        geometry = "300x5-10-50";
        indicate_hidden = "yes";
        shrink = "no";
        transparency = 10;
        notification_height = 0;
        separator_height = 2;
        padding = 10;
        horizontal_padding = 10;
        frame_width = 2;
        frame_color = "#fab283";
        separator_color = "frame";
        sort = "yes";
        idle_threshold = 120;
        font = "JetBrainsMono Nerd Font 11";
        line_height = 0;
        markup = "full";
        format = "<b>%s</b>\n%b";
        alignment = "left";
        vertical_alignment = "center";
        show_age_threshold = 60;
        word_wrap = "yes";
        ignore_newline = "no";
        stack_duplicates = true;
        hide_duplicate_count = false;
        show_indicators = "yes";
        icon_position = "left";
        min_icon_size = 0;
        max_icon_size = 32;
        sticky_history = "yes";
        history_length = 20;
        browser = "xdg-open";
        always_run_script = true;
        title = "Dunst";
        class = "Dunst";
        corner_radius = 4;
        layer = "overlay";
        dmenu = "${pkgs.rofi}/bin/rofi -dmenu -p dunst: -theme opencode";
      };
      urgency_low = {
        background = "#141414";
        foreground = "#323232";
        timeout = 4;
      };
      urgency_normal = {
        background = "#1e1e1e";
        foreground = "#eeeeee";
        timeout = 6;
      };
      urgency_critical = {
        background = "#e06c75";
        foreground = "#eeeeee";
        frame_color = "#e06c75";
        timeout = 0;
      };
    };
  };
}
