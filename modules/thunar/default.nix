{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-media-tags-plugin
    xfce.thunar-volman
    xfce.tumbler
  ];

  xdg.mimeApps = {
    defaultApplications = {
      "inode/directory" = "thunar";
      "application/x-iso9660-image" = "thunar";
      "application/x-rar-compressed" = "thunar";
      "application/x-tar" = "thunar";
      "application/zip" = "thunar";
      "application/x-xz-compressed-tar" = "thunar";
      "application/x-bzip-compressed-tar" = "thunar";
      "application/x-gzip-compressed-tar" = "thunar";
    };
  };
}
