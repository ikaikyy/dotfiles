{ config, pkgs, hostName, ... }: {
  imports = [
    ./backlight.nix
    ./bluetooth.nix
    ./boot.nix
    ./configuration.nix
    ./gnupg.nix
    ./greetd.nix
  ] ++ (if (hostName == "desktop") then [
    ./virtualisation.nix
    ./steam.nix
    ./jellyfin.nix
  ] else if (hostName == "laptop") then
    [ ]
  else
    [ ]);
}
