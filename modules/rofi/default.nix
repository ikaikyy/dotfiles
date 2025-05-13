{ config, pkgs, ... }: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    theme = let
      rosewater = "#f5e0dc";
      flamingo = "#f2cdcd";
      pink = "#f5c2e7";
      mauve = "#cba6f7";
      red = "#f38ba8";
      maroon = "#eba0ac";
      peach = "#fab387";
      yellow = "#f9e2af";
      green = "#a6e3a1";
      teal = "#94e2d5";
      sky = "#89dceb";
      sapphire = "#74c7ec";
      blue = "#89b4fa";
      lavender = "#b4befe";
      text = "#cdd6f4";
      subtext1 = "#bac2de";
      subtext0 = "#a6adc8";
      overlay2 = "#9399b2";
      overlay1 = "#7f849c";
      overlay0 = "#6c7086";
      surface2 = "#585b70";
      surface1 = "#45475a";
      surface0 = "#313244";
      base = "#1e1e2e";
      mantle = "#181825";
      crust = "#11111b";

      inherit (config.lib.formats.rasi) mkLiteral;

      normalElement = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral text;
      };
      selectedElement = {
        background-color = mkLiteral mauve;
        text-color = mkLiteral mantle;
      };
    in {
      configuration = {
        show-icons = true;
        drun-display-format = "{name}";
      };

      "*" = {
        background = mkLiteral mantle;
        border = mkLiteral "none";
        font = "JetBrainsMono Nerd Font 13";
        foreground = mkLiteral text;
        lightbg = mkLiteral "transparent";
      };

      element = {
        border-radius = mkLiteral "12px";
        padding = mkLiteral "12px";
      };

      "element normal.normal" = normalElement;
      "element alternate.normal" = normalElement;

      "element selected.normal" = selectedElement;
      "element selected.alternate" = selectedElement;
      "element selected.active" = selectedElement;

      element-text = { font-size = mkLiteral "16px"; };

      entry = {
        padding = mkLiteral "10px";
        placeholder = "Search...";
      };

      inputbar = {
        children = map mkLiteral [ "textbox-prompt-colon" "entry" ];
      };

      listview = {
        border = mkLiteral "0";
        lines = mkLiteral "6";
        scrollbar = false;
        spacing = mkLiteral "12px";
      };

      mainbox = { spacing = mkLiteral "16px"; };

      scrollbar = { handle-border-radius = mkLiteral "8px"; };

      textbox-prompt-colon = {
        background-color = mkLiteral mauve;
        border-radius = mkLiteral "12px";
        color = mkLiteral mantle;
        font = "JetBrainsMono Nerd Font Mono 18";
        padding = mkLiteral "6px 18px";
        str = "";
      };

      window = {
        background-color = mkLiteral mantle;
        border = mkLiteral "none";
        border-radius = mkLiteral "16px";
        padding = mkLiteral "20px";

        width = mkLiteral "30%";
      };
    };
  };
}
