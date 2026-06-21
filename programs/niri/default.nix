{
  pkgs,
  ...
}:
{
  imports = [
    ../cliphist
    ../dunst
    ../rofi
    ../desktop
    ../hyprlock
    (import ../waybar {
      modules-left = [ "niri/workspaces" ];
      modules-center = [ "niri/window" ];
      language-module = "niri/language";
      extra-settings = {
        "niri/workspaces" = {
          disable-scroll = true;
          all-outputs = false;
          format = "{icon}";
          format-icons = { active = " "; default = " "; };
        };
        "niri/window" = {
          format = "{title}";
          max-length = 80;
          separate-outputs = false;
        };
        "niri/language" = {
          format = "{shortDescription}";
          tooltip = true;
          tooltip-format = "{shortDescription} - {longDescription}";
        };
      };
    })
  ];

  xdg.configFile."niri/config.kdl".source = ./config.kdl;

  home.packages = with pkgs; [ awww ];

  services.swayidle = {
    enable = true;
    events = [
      { event = "before-sleep"; command = "${pkgs.hyprlock}/bin/hyprlock"; }
      { event = "lock"; command = "${pkgs.hyprlock}/bin/hyprlock"; }
    ];
    timeouts = [
      { timeout = 300; command = "${pkgs.hyprlock}/bin/hyprlock"; }
      {
        timeout = 600;
        command = "${pkgs.niri}/bin/niri msg power-off-monitors";
        resumeCommand = "${pkgs.niri}/bin/niri msg power-on-monitors";
      }
    ];
  };
}
