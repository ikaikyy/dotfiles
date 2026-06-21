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
      postgresql_18
      ydotool
      parted
      opencode

      chromium # For things that requires chrome
      insomnia
      thunderbird
      pwvucontrol
      pulseaudio
      _1password-cli
      _1password-gui
    ]
    ++ (
      if (hostName == "desktop") then
        [
          # Desktop specific
          genymotion
          (prismlauncher.override {
            jdks = [
              graalvmPackages.graalvm-oracle_17
              javaPackages.compiler.openjdk17-bootstrap
              javaPackages.compiler.openjdk8-bootstrap
            ];
          })
          jetbrains.idea
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
    ./programs/niri
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
