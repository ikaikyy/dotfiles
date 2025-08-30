{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    wineWowPackages.waylandFull
    lutris
    hydralauncher
  ];

  programs = {
    gamescope = {
      enable = true;
      capSysNice = true;
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
