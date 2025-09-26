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
    NIXOS_OZONE_WL = 1;
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
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
      bootstrap-studio
      chromium # For things that requires chrome
      insomnia
    ]
    ++ (
      if (hostName == "desktop")
      then [
        # Desktop specific
        genymotion
        android-studio
        prismlauncher
        (jetbrains.datagrip.override {jdk = pkgs.openjdk21;})
        (jetbrains.idea-ultimate.override {jdk = pkgs.openjdk21;})
        dotnet-sdk_8
        gimp
        lmstudio
        ciscoPacketTracer8
      ]
      else []
    );

  xdg.mimeApps.enable = true;

  imports =
    [
      inputs.zen-browser.homeModules.twilight
      ./programs/neovim
      ./programs/shell
      ./programs/gnome
      ./programs/git
      ./programs/zen-browser
      ./programs/spotify
      ./programs/discord
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
