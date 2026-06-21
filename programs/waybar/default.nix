{
  modules-left,
  modules-center,
  language-module,
  extra-settings ? { },
}:
let
  common = {
    layer = "top";
    position = "top";
    height = 32;
    spacing = 4;
    modules-right = [
      "tray"
      "pulseaudio"
      "backlight"
      "network"
      "cpu"
      "memory"
      language-module
      "clock"
    ];

    tray.icon-size = 18;

    pulseaudio = {
      format = "{icon} {volume}%";
      format-bluetooth = "{icon} {volume}%";
      format-muted = "muted";
      format-icons.default = [ " " " " " " ];
      on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      on-click-right = "pwvucontrol";
      scroll-step = 5;
    };

    backlight = {
      format = "{icon} {percent}%";
      format-icons = [ "󰃞" "󰃟" "󰃠" ];
      tooltip = false;
      on-scroll-up = "brightnessctl set 5%+";
      on-scroll-down = "brightnessctl set 5%-";
    };

    network = {
      format-wifi = "  {signalStrength}%";
      format-ethernet = "eth";
      format-disconnected = "off";
      tooltip-format = "{ifname}: {ipaddr}/{cidr}";
      on-click = "nm-connection-editor";
    };

    cpu = {
      interval = 2;
      format = "  {usage}%";
      on-click = "ghostty -e btop";
    };

    memory = {
      interval = 5;
      format = "  {used:0.1f}G";
      on-click = "ghostty -e btop";
    };

    clock = {
      format = "  {:%a %d %b  %H:%M}";
      tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      on-click-right = "ghostty -e calcurse";
    };
  };
in
{
  programs.waybar = {
    enable = true;
    systemd.enable = false;
    style = builtins.readFile ./style.css;
    settings = [
      (common // {
        inherit modules-left modules-center;
      } // extra-settings)
    ];
  };
}
