{
  config,
  pkgs,
  ...
}: {
  programs.zen-browser = {
    enable = true;

    profiles.kaiky = {
      extensions = {
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          onepassword-password-manager
          ublock-origin
          darkreader
        ];
      };
    };
  };

  xdg.mimeApps = {
    defaultApplications = {
      "text/html" = "zen-twilight";
      "x-scheme-handler/http" = "zen-twilight";
      "x-scheme-handler/https" = "zen-twilight";
      "x-scheme-handler/about" = "zen-twilight";
      "x-scheme-handler/unknown" = "zen-twilight";
      "application/xhtml+xml" = "zen-twilight";
      "application/x-xpinstall" = "zen-twilight";
      "application/x-xpinstall-manifest" = "zen-twilight";
      "application/x-web-app-manifest+json" = "zen-twilight";
      "application/x-web-app-manifest+json; charset=utf-8" = "zen-twilight";
      "application/xhtml+xml; charset=utf-8" = "zen-twilight";
    };
  };
}
