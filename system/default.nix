{
  config,
  pkgs,
  hostName,
  ...
}: {
  imports =
    [
      ./backlight.nix
      ./bluetooth.nix
      ./boot.nix
      ./configuration.nix
      ./gnupg.nix
      ./greetd.nix
    ]
    ++ (
      if (hostName == "desktop")
      then [
        ./jellyfin.nix
        ./sshd.nix
        ./steam.nix
        ./virtualisation.nix
      ]
      else if (hostName == "laptop")
      then []
      else []
    );
}
