{ config, pkgs, ... }: {
  programs.firefox = { enable = true; };

  home.sessionVariables.DEFAULT_BROWSER = "firefox";

  xdg.mimeApps = {
    defaultApplications = {
      "text/html" = "firefox";
      "x-scheme-handler/http" = "firefox";
      "x-scheme-handler/https" = "firefox";
      "x-scheme-handler/about" = "firefox";
      "x-scheme-handler/unknown" = "firefox";
      "application/xhtml+xml" = "firefox";
      "application/x-xpinstall" = "firefox";
      "application/x-xpinstall-manifest" = "firefox";
      "application/x-web-app-manifest+json" = "firefox";
      "application/x-web-app-manifest+json; charset=utf-8" = "firefox";
      "application/xhtml+xml; charset=utf-8" = "firefox";
    };
  };
}
