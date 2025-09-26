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
      "text/html" = "zen-twilight.desktop";
      "x-scheme-handler/http" = "zen-twilight.desktop";
      "x-scheme-handler/https" = "zen-twilight.desktop";
      "x-scheme-handler/about" = "zen-twilight.desktop";
      "x-scheme-handler/unknown" = "zen-twilight.desktop";
      "application/xhtml+xml" = "zen-twilight.desktop";
      "application/x-xpinstall" = "zen-twilight.desktop";
      "application/x-xpinstall-manifest" = "zen-twilight.desktop";
      "application/x-web-app-manifest+json" = "zen-twilight.desktop";
      "application/x-web-app-manifest+json; charset=utf-8" = "zen-twilight.desktop";
      "application/xhtml+xml; charset=utf-8" = "zen-twilight.desktop";
    };
  };
}
