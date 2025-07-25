{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./backlight.nix
    ./bluetooth.nix
    ./boot.nix
    ./configuration.nix
    ./gnupg.nix
    ./greetd.nix
    ./jellyfin.nix
    ./steam.nix
    ./virtualisation.nix
  ];
}
