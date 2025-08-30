{
  config,
  pkgs,
  inputs,
  hostName,
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
  home.packages = with pkgs;
    [
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
      postgresql_15
      ydotool
      gemini-cli

      smtp4dev
      gitkraken
      chromium # For things that requires chrome
    ]
    ++ (
      if (hostName == "desktop")
      then [
        # Desktop specific
        android-studio
        prismlauncher
        (jetbrains.datagrip.override {jdk = pkgs.openjdk21;})
        (jetbrains.rider.override {jdk = pkgs.openjdk21;})
        dotnet-sdk_8
        gimp
      ]
      else []
    );

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  xdg.mimeApps.enable = true;

  imports =
    [
      inputs.zen-browser.homeModules.twilight
      ./programs/neovim
      ./programs/shell
      ./programs/hyprland
      ./programs/gtk
      ./programs/wezterm
      ./programs/git
      ./programs/ssh
      ./programs/clipboard
      ./programs/printscreen
      ./programs/nautilus
      ./programs/zen-browser
      ./programs/spotify
      ./programs/discord
      ./programs/ags
      ./programs/retroarch
    ]
    ++ (
      if (hostName == "desktop")
      then []
      else if (hostName == "laptop")
      then []
      else []
    );
}
