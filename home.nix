{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.username = "kaiky";
  home.homeDirectory = "/home/kaiky";
  home.stateVersion = "24.11";

  home.sessionVariables = {
    HYPRCURSOR_THEME = "Bibata-Modern-Ice";
    HYPRCURSOR_SIZE = 24;
    NIXOS_OZONE_WL = 1;
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
  };

  # User packages (not system-wide)
  home.packages = with pkgs; [
    # Fonts
    noto-fonts
    noto-fonts-lgc-plus
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    dejavu_fonts
    freefont_ttf
    wqy_microhei
    nerd-fonts.jetbrains-mono
    nerd-fonts.hack

    # CLI
    unzip
    unrar
    heroku
    graalvmPackages.graalvm-ce
    mysql80

    android-studio
    prismlauncher
    smtp4dev
    qbittorrent
    jetbrains.datagrip
  ];

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  xdg.mimeApps.enable = true;

  imports = [
    ./modules/neovim
    ./modules/shell
    ./modules/hyprland
    ./modules/gtk
    ./modules/kitty
    ./modules/git
    ./modules/clipboard
    ./modules/printscreen
    ./modules/nautilus
    ./modules/firefox
    ./modules/spotify
    ./modules/discord
    ./modules/ags
    ./modules/retroarch
  ];
}
