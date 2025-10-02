{pkgs, ...}: {
  imports = [
    ./keybinds.nix
    ./gtk.nix
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
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 20;
  };
}
