{...}: {
  dconf.settings = {
    "org/gnome/desktop/wm/keybindings" = {
      switch-to-workspace-1 = ["<Super>1"];
      switch-to-workspace-2 = ["<Super>2"];
      switch-to-workspace-3 = ["<Super>3"];
      switch-to-workspace-4 = ["<Super>4"];
      switch-to-workspace-5 = ["<Super>5"];
      switch-to-workspace-6 = ["<Super>6"];
      switch-to-workspace-7 = ["<Super>7"];
      switch-to-workspace-8 = ["<Super>8"];
      switch-to-workspace-9 = ["<Super>9"];

      close = ["<Super>q"];
      toggle-fullscreen = ["<Super>f"];
      toggle-maximized = ["<Super>m"];

      switch-applications = [];
      switch-windows = ["<Alt>Tab"];

      activate-window-menu = [];
    };

    "org/gnome/shell/keybindings" = {
      switch-to-application-1 = [];
      switch-to-application-2 = [];
      switch-to-application-3 = [];
      switch-to-application-4 = [];
      switch-to-application-5 = [];
      switch-to-application-6 = [];
      switch-to-application-7 = [];
      switch-to-application-8 = [];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-terminal/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-terminal" = {
      binding = "<Primary><Alt>t";
      command = "ghostty";
      name = "open-terminal";
    };
  };
}
