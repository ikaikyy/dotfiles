{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./configuration.nix
    ./greetd.nix
    ./gnupg.nix
    ./steam.nix
    ./backlight.nix
    ./boot.nix
    ./bluetooth.nix
    ./jellyfin.nix
  ];
}
