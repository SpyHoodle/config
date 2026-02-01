{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    host.desktop.waybar.enable = lib.mkEnableOption "Use waybar as your top bar";
  };

  config = lib.mkIf config.host.desktop.waybar.enable {
    programs.waybar = {
      enable = true;

      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          margin = "0 0 0 0";
          modules-left = [ "hyprland/workspaces" ];
          modules-center = [ "hyprland/window" ];
          modules-right = [
            "tray"
            "privacy"
            "pulseaudio"
            "temperature"
            "cpu"
            "custom/mem"
            "network#ethernet"
            "network#tailscale"
            "clock"
          ];
          "hyprland/window" = {
            "icon" = true;
          };
          "tray" = {
            "icon-size" = 21;
            "spacing" = 10;
          };
          disk = {
            "interval" = 30;
            "format" = "  {specific_used:0.1f}/{specific_total:0.1f} GB";
            "path" = "/";
            unit = "GB";
          };
          temperature = {
            thermal-zone = 2;
            critical-threshold = 80;
            format = "  {temperatureC}°C";
            "hwmon-path" = "/sys/class/hwmon/hwmon1/temp1_input";
          };
          privacy = {
            "icon-size" = 17;
            "transition-duration" = 250;
            "modules" = [
              {
                "type" = "screenshare";
                "tooltip" = true;
                "tooltip-icon-size" = 24;
              }
              {
                "type" = "audio-in";
                "tooltip" = true;
                "tooltip-icon-size" = 24;
              }
            ];
          };
          "hyprland/window" = {
            "max-length" = 50;
          };
          "network#ethernet" = {
            "interface" = "wlp15s0";
            "format" = " ";
            "format-ethernet" = " ";
            "format-wifi" = " ";
            "format-disconnected" = " {ifname}";
            "tooltip-format-ethernet" = "  {ifname}";
            "tooltip-format-disconnected" = " Disconnected: {ifname}";
            "max-length" = 50;
            "min-length" = 2;
          };
          "network#tailscale" = {
            "interface" = "tailscale0";
            "format" = "{ifname}: Connecting";
            "format-ethernet" = " ";
            "format-wifi" = " ";
            "format-disconnected" = " ";
            "tooltip-format-ethernet" = "  {ifname}";
            "tooltip-format-disconnected" = "  Disconnected: {ifname}";
            "max-length" = 50;
            "min-length" = 2;
          };
          "clock" = {
            "interval" = 1;
            "format" = "  {:%T}";
            "format-alt" = "  {:%a %d %b %Y, %T}";
            "tooltip-format" = "<tt><small>{calendar}</small></tt>";
            "calendar" = {
              "mode" = "year";
              "mode-mon-col" = 3;
              "weeks-pos" = "right";
              "on-scroll" = 1;
              "format" = {
                "months" = "<span color='#ffead3'><b>{}</b></span>";
                "days" = "<span color='#ecc6d9'><b>{}</b></span>";
                "weeks" = "<span color='#99ffdd'><b>W{}</b></span>";
                "weekdays" = "<span color='#ffcc66'><b>{}</b></span>";
                "today" = "<span color='#ff6699'><b><u>{}</u></b></span>";
              };
            };
            "actions" = {
              "on-click-right" = "mode";
              "on-scroll-up" = "shift_up";
              "on-scroll-down" = "shift_down";
            };
          };
          "pulseaudio" = {
            "scroll-step" = 1;
            "reverse-scrolling" = 1;
            "format" = "{icon} {volume}% {format_source}";
            "format-bluetooth" = "{icon}  {volume}% {format_source}";
            "format-bluetooth-muted" = " {icon}  {format_source}";
            "format-muted" = "  {format_source}";
            "format-source" = " {volume}%";
            "format-source-muted" = " ";
            "format-icons" = {
              "headphone" = " ";
              "hands-free" = "";
              "headset" = " ";
              "phone" = " ";
              "portable" = " ";
              "car" = " ";
              "default" = [
                " "
                " "
                " "
              ];
            };
            "on-click" = "${pkgs.pavucontrol}/bin/pavucontrol";
            "min-length" = 13;
          };
          "custom/mem" = {
            "format" = "  {}";
            "interval" = 5;
            "exec" = "free -h | awk '/Mem:/{printf $3}'";
            "tooltip" = false;
            "min-length" = 6;
          };
          "cpu" = {
            "interval" = 2;
            "format" = "  {usage}%";
            "min-length" = 4;
          };
        };
      };

      style =
        ''
          @define-color background #${config.host.theme.colors.pallete.base00.hex};
          @define-color active #${config.host.theme.colors.pallete.${config.host.theme.colors.accent}.hex};
          @define-color hover #${config.host.theme.colors.pallete.base01.hex};
          @define-color text #${config.host.theme.colors.pallete.base05.hex};
          @define-color altText #${config.host.theme.colors.pallete.base05.hex};
          @define-color black #${config.host.theme.colors.pallete.base02.hex};
          @define-color red #${config.host.theme.colors.pallete.base08.hex};
          @define-color orange #${config.host.theme.colors.pallete.base09.hex};
          @define-color yellow #${config.host.theme.colors.pallete.base0A.hex};
          @define-color green #${config.host.theme.colors.pallete.base0B.hex};
          @define-color magenta #${config.host.theme.colors.pallete.base0E.hex};
          @define-color cyan #${config.host.theme.colors.pallete.base0C.hex};
          @define-color blue #${config.host.theme.colors.pallete.base0D.hex};
        ''
        + builtins.readFile ./style.css;
    };
  };
}
