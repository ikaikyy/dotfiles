{
  config,
  pkgs,
  inputs,
  hostName,
  ...
}:
{
  home.username = "ikaikyy";
  home.homeDirectory = "/home/ikaikyy";
  home.stateVersion = "24.11";

  home.sessionVariables = {
    NIXOS_OZONE_WL = 1;
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    SDL_VIDEODRIVER = "wayland";
    SDL_VIDEO_WAYLAND_ALLOW_LIBDECOR = "0";
    GTK_CSD = "0";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
  };

  # User packages (not system-wide)
  home.packages =
    with pkgs;
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
      postgresql_18
      ydotool
      gemini-cli
      opencode
      ntfs3g
      parted

      smtp4dev
      chromium # For things that requires chrome
      insomnia
      thunderbird
      pwvucontrol
      pulseaudio
      ventoy-full-gtk
      _1password-cli
      _1password-gui
    ]
    ++ (
      if (hostName == "desktop") then
        [
          # Desktop specific
          genymotion
          android-studio
          (prismlauncher.override {
            jdks = [
              graalvmPackages.graalvm-oracle_17
              javaPackages.compiler.openjdk17-bootstrap
              javaPackages.compiler.openjdk8-bootstrap
            ];
          })
          (jetbrains.datagrip.override { jdk = pkgs.openjdk21; })
          jetbrains.idea
          gimp
          lmstudio
          android-tools
        ]
      else
        [ ]
    );

  xdg.mimeApps.enable = true;

  imports = [
    inputs.zen-browser.homeModules.twilight
    ./programs/neovim
    ./programs/shell
    ./programs/gnome/gtk.nix
    ./programs/gnome
    ./programs/git
    ./programs/zen-browser
    ./programs/spotify
    ./programs/discord
    ./programs/retroarch
  ]
  ++ (
    if (hostName == "desktop") then
      [ ]
    else if (hostName == "laptop") then
      [ ]
    else
      [ ]
  );
}
