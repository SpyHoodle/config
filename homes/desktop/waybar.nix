{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        #margin = "10 10 0 10";
        margin = "0 0 0 0";
        modules-left = [ "hyprland/workspaces" "hyprland/window" ];
        modules-center = [ ];
        modules-right = [ "privacy" "tray" "pulseaudio" "temperature" "custom/mem" "cpu" "disk" "network" "clock" ];
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
        network = {
          "interface" = "eno1";
          "format" = "{ifname}: Connecting";
          "format-ethernet" = "  {ipaddr}";
          "format-disconnected" = "{ifname}: Disconnected";
          "tooltip-format" = "{ifname} via {gwaddr} 󰊗";
          "tooltip-format-wifi" = "{essid} ({signalStrength}%) ";
          "tooltip-format-ethernet" = "{ifname} ";
          "tooltip-format-disconnected" = "Disconnected";
          "max-length" = 50;
        };
        clock = {
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
        pulseaudio = {
          "scroll-step" = 1;
          "reverse-scrolling" = 1;
          "format" = "{icon} {volume}% {format_source}";
          "format-bluetooth" = "{icon}  {volume}% {format_source}";
          "format-bluetooth-muted" = " {icon}  {format_source}";
          "format-muted" = "  {format_source}";
          "format-source" = " {volume}%";
          "format-source-muted" = " ";
          "format-icons" = {
              "headphone" = " ";
              "hands-free" = "";
              "headset" = " ";
              "phone" = " ";
              "portable" = " ";
              "car" = " ";
              "default" = ["" " " " "];
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
        cpu = {
          "interval" = 2;
          "format" = "  {usage}%";
          "min-length" = 6;
        };

      };
    };

    /*style = ''
      @define-color background #282c34;
      @define-color active #528BFF;
      @define-color hover #1D2025;
      @define-color text #ABB2BF;
      @define-color altText #ABB2BF;
      @define-color critical #E06C75;
      @define-color warning #E5C07B;
      @define-color charging #98C379;
    '' + builtins.readFile ./waybar/main.css;*/

    style = builtins.readFile ./waybar/main.css;

  };
}
