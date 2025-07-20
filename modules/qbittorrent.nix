{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.qbittorrent;
in {
  options.services.qbittorrent = {
    enable = mkEnableOption "qBittorrent-nox service";

    user = mkOption {
      type = types.str;
      default = "qbittorrent";
      description = "User to run qBittorrent as.";
    };

    group = mkOption {
      type = types.str;
      default = "qbittorrent";
      description = "Group to run qBittorrent as.";
    };

    dataDir = mkOption {
      type = types.path;
      default = "/var/lib/qbittorrent";
      description = "The directory where qBittorrent stores its data.";
    };

    openFirewall = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to open the firewall for the web UI.";
    };

    webuiPort = mkOption {
      type = types.port;
      default = 8080;
      description = "The port for the qBittorrent web UI.";
    };
  };

  config = mkIf cfg.enable {
    users.users.${cfg.user} = {
      isSystemUser = true;
      group = cfg.group;
      home = cfg.dataDir;
    };

    users.groups.${cfg.group} = {};

    systemd.services.qbittorrent = {
      description = "qBittorrent Daemon";
      after = ["network.target"];
      wantedBy = ["multi-user.target"];

      serviceConfig = {
        User = cfg.user;
        Group = cfg.group;
        ExecStart = "${pkgs.qbittorrent-nox}/bin/qbittorrent-nox --webui-port=${toString cfg.webuiPort}";
        WorkingDirectory = cfg.dataDir;
        Restart = "on-failure";
      };
    };

    networking.firewall = mkIf cfg.openFirewall {
      allowedTCPPorts = [cfg.webuiPort];
    };
  };
}
