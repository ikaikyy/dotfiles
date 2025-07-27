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
      "text/html" = "zen-browser";
      "x-scheme-handler/http" = "zen-browser";
      "x-scheme-handler/https" = "zen-browser";
      "x-scheme-handler/about" = "zen-browser";
      "x-scheme-handler/unknown" = "zen-browser";
      "application/xhtml+xml" = "zen-browser";
      "application/x-xpinstall" = "zen-browser";
      "application/x-xpinstall-manifest" = "zen-browser";
      "application/x-web-app-manifest+json" = "zen-browser";
      "application/x-web-app-manifest+json; charset=utf-8" = "zen-browser";
      "application/xhtml+xml; charset=utf-8" = "zen-browser";
    };
  };
}
