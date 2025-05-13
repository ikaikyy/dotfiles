{ config, pkgs, ... }: {
  home.packages = with pkgs; [ vesktop ];

  xdg.desktopEntries.vesktop = {
    name = "Vesktop";
    exec =
      "${pkgs.vesktop}/bin/vesktop --enable-features=UseOzonePlatform --ozone-platform=wayland %U";
    icon = "vesktop";
    terminal = false;
    type = "Application";
    categories = [ "Network" "InstantMessaging" ];
    mimeType = [ "x-scheme-handler/discord" ];
    startupNotify = true;
  };
}
