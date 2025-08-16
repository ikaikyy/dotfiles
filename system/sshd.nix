{
  config,
  pkgs,
  ...
}: {
  services.openssh = {
    enable = true;
    ports = [22];
    settings = {
      AllowUsers = null;
      PasswordAuthentication = false;
      PubkeyAuthentication = true;
      PermitRootLogin = "prohibit-password";
    };
  };

  services.fail2ban = {
    enable = true;
    maxretry = 5;
    bantime = "24h";
    bantime-increment = {
      enable = true;
      multipliers = "1 2 4 8 16 32 64 128 256";
      overalljails = true;
    };
  };

  networking.firewall = {
    allowedTCPPorts = [22];
    allowedUDPPorts = [];
  };
}
