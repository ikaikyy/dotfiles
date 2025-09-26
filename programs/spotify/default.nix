{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = [pkgs.spotify];

  # Force xwayland for spotify as it doesn't draw draw it's own title bar
  xdg.desktopEntries.spotify = {
    name = "Spotify";
    exec = "${pkgs.spotify}/bin/spotify --ozone-platform=x11 %U";
    icon = "spotify-client";
    terminal = false;
    type = "Application";
    categories = [
      "Audio"
      "Music"
      "Player"
      "AudioVideo"
    ];
    mimeType = ["x-scheme-handler/spotify"];
  };
}
