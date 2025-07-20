{
  config,
  pkgs,
  ...
}: {
  fileSystems."/mnt/datastore" = {
    device = "/dev/disk/by-label/datastore";
    fsType = "ext4";
    options = ["noatime" "nodiratime"];
  };

  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
    qbittorrent
  ];

  services.qbittorrent = {
    enable = true;
    openFirewall = true;
    user = "qbittorrent";
    group = "qbittorrent";
    dataDir = "/mnt/datastore/qbittorrent";
    webuiPort = 8080;
  };

  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "jellyfin";
    group = "jellyfin";
    cacheDir = "/mnt/datastore/jellyfin/cache";
    configDir = "/mnt/datastore/jellyfin/config";
    dataDir = "/mnt/datastore/jellyfin";
    logDir = "/mnt/datastore/jellyfin/logs";
  };

  services.sonarr = {
    enable = true;
    openFirewall = true;
    user = "sonarr";
    group = "sonarr";
    dataDir = "/mnt/datastore/sonarr";
  };

  services.radarr = {
    enable = true;
    openFirewall = true;
    user = "radarr";
    group = "radarr";
    dataDir = "/mnt/datastore/radarr";
  };

  services.prowlarr = {
    enable = true;
    openFirewall = true;
  };

  services.jellyseerr = {
    enable = true;
    openFirewall = true;
  };

  services.flaresolverr = {
    enable = true;
    openFirewall = true;
  };
}
