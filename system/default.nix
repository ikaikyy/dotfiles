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
      ./nix-ld.nix
      ./1password.nix
      ./tailscale.nix
      ./hermes-agent.nix
    ]
    ++ (
      if (hostName == "desktop")
      then [
        # ./jellyfin.nix
        ./sshd.nix
        ./games.nix
        ./virtualisation.nix
        ./cloudflared.nix
      ]
      else if (hostName == "laptop")
      then []
      else []
    );
}
