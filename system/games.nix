{
  config,
  pkgs,
  ...
}:
{
  fileSystems."/run/media/ikaikyy/Games" = {
    device = "/dev/disk/by-label/nvme-1tb";
    fsType = "ext4";
    options = [
      "defaults"
      "rw"
      "exec"
      "nofail"
    ];
  };

  systemd.tmpfiles.rules = [
    "d /run/media/ikaikyy/Games 0755 ikaikyy users -"
  ];

  environment.systemPackages = with pkgs; [
    wineWowPackages.waylandFull
    lutris
    hydralauncher
  ];

  programs = {
    gamescope = {
      enable = true;
      capSysNice = false;
    };
    gamemode = {
      enable = true;
    };
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
  };
}
