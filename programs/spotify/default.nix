{ config, pkgs, inputs, ... }:
let spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  imports = [ inputs.spicetify-nix.homeManagerModules.spicetify ];

  programs.spicetify = {
    enable = true;

    enabledExtensions = with spicePkgs.extensions; [ adblock ];

    # onepunch is a gruvbox theme
    theme = spicePkgs.themes.onepunch;

    colorScheme = "dark";
  };

  xdg.desktopEntries.spotify = {
    name = "Spotify";
    exec =
      "${config.programs.spicetify.spicedSpotify}/bin/spotify --enable-features=UseOzonePlatform --ozone-platform=wayland %U";
    icon = "spotify-client";
    terminal = false;
    type = "Application";
    categories = [ "Audio" "Music" "Player" "AudioVideo" ];
    mimeType = [ "x-scheme-handler/spotify" ];
  };
}
