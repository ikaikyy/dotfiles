{ config, pkgs, hostName, ... }: {
  programs.kitty = {
    enable = true;

    font = {
      name = "JetBrainsMono NerdFont";
      package = pkgs.nerd-fonts.jetbrains-mono;
      size = if hostName == "desktop" then 14 else 12;
    };

    settings = {
      enabled_layouts = "splits";

      background_opacity = 0.8;
      background_blur = 1;
    };

    keybindings = {
      # Tabs
      "alt+shift+n" = "new_tab";
      "alt+shift+," = "previous_tab";
      "alt+shift+." = "next_tab";

      # Windows
      "alt+shift+[" = "launch --location=hsplit --cwd=current";
      "alt+shift+]" = "launch --location=vsplit --cwd=current";
      "alt+shift+q" = "close_window";
      "alt+shift++" = "resize_window wider 5";
      "alt+shift+-" = "resize_window narrower 5";

      # Switch focus between windows using hjkl
      "alt+shift+h" = "neighboring_window left";
      "alt+shift+j" = "neighboring_window down";
      "alt+shift+k" = "neighboring_window up";
      "alt+shift+l" = "neighboring_window right";
    };

    themeFile = "gruvbox-dark-hard";
  };
}
