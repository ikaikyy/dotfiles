{
  config,
  pkgs,
  ...
}:
{
  services.cloudflared = {
    enable = true;
    tunnels = {
      "db990d74-3fa3-4456-9101-eec531bd561c" = {
        credentialsFile = "/var/lib/cloudflared/opencode-tunnel.json";
        default = "http_status:404";
        ingress = {
          "opencode.kaikyeduardo.dev" = "http://localhost:3003";
        };
      };
    };
  };
}
