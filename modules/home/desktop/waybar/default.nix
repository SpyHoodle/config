{
  config,
  lib,
  pkgs,
  ...
}:

let
  # Theme shortcuts for cleaner code
  palette = config.host.theme.colors.pallete;
  accent = config.host.theme.colors.accent;
  font = config.host.theme.font;
in
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
            "network#wifi"
            "network#tailscale"
            "clock"
          ];

          # Window title
          "hyprland/window" = {
            icon = true;
            icon-size = 18;
            max-length = 50;
            rewrite = {
              "(.*) — Mozilla Firefox" = "󰈹 $1";
              "(.*) - Chromium" = " $1";
              "(.*) - Visual Studio Code" = "󰨞 $1";
              "(.*) - Zed" = " $1";
            };
          };

          # System tray
          tray = {
            icon-size = 18;
            spacing = 8;
            show-passive-items = true;
          };

          # Disk usage
          disk = {
            interval = 30;
            format = "󰋊 {percentage_used}%";
            path = "/";
            tooltip-format = "󰋊 Storage\n\nUsed: {used} / {total}\nFree: {free} ({percentage_free}% available)";
          };

          # Temperature
          temperature = {
            thermal-zone = 2;
            critical-threshold = 80;
            format = " {temperatureC}°C";
            format-critical = " {temperatureC}°C";
            tooltip-format = " CPU Temperature\n\n{temperatureC}°C / {temperatureF}°F";
            hwmon-path = "/sys/class/hwmon/hwmon1/temp1_input";
          };

          # Privacy indicators
          privacy = {
            icon-size = 17;
            transition-duration = 250;
            modules = [
              {
                type = "screenshare";
                tooltip = true;
                tooltip-icon-size = 24;
              }
              {
                type = "audio-in";
                tooltip = true;
                tooltip-icon-size = 24;
              }
            ];
          };

          # WiFi/Ethernet
          "network#wifi" = {
            interface = "wlp*";
            format = "󰤨";
            format-ethernet = "󰈀";
            format-wifi = "󰤨 {signalStrength}%";
            format-disconnected = "󰤭";
            format-disabled = "󰤮";
            tooltip-format-wifi = ''󰤨 WiFi Connected

SSID: {essid}
Signal: {signalStrength}% ({signaldBm} dBm)
Frequency: {frequency} MHz
IP: {ipaddr}/{cidr}
Gateway: {gwaddr}
↑ {bandwidthUpBytes}  ↓ {bandwidthDownBytes}'';
            tooltip-format-ethernet = ''󰈀 Ethernet Connected

Interface: {ifname}
IP: {ipaddr}/{cidr}
Gateway: {gwaddr}
↑ {bandwidthUpBytes}  ↓ {bandwidthDownBytes}'';
            tooltip-format-disconnected = "󰤭 Network Disconnected";
            max-length = 50;
            min-length = 2;
            on-click = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
          };

          # Tailscale VPN
          "network#tailscale" = {
            interface = "tailscale0";
            format = "󰖂";
            format-ethernet = "󰖂";
            format-disconnected = "󰖃";
            tooltip-format-ethernet = ''󰖂 Tailscale Connected

Interface: {ifname}
IP: {ipaddr}/{cidr}
↑ {bandwidthUpBytes}  ↓ {bandwidthDownBytes}'';
            tooltip-format-disconnected = "󰖃 Tailscale Disconnected";
            max-length = 50;
            min-length = 2;
          };

          # Clock
          clock = {
            interval = 1;
            format = " {:%H:%M}";
            format-alt = " {:%a %d %b %Y, %H:%M:%S}";
            tooltip-format = ''<tt><small>{calendar}</small></tt>

<b>Timezone:</b> {tz_list}'';
            calendar = {
              mode = "year";
              mode-mon-col = 3;
              weeks-pos = "right";
              on-scroll = 1;
              format = {
                months = "<span color='#${palette.base0A.hex}'><b>{}</b></span>";
                days = "<span color='#${palette.base05.hex}'>{}</span>";
                weeks = "<span color='#${palette.base0B.hex}'><b>W{}</b></span>";
                weekdays = "<span color='#${palette.base09.hex}'><b>{}</b></span>";
                today = "<span color='#${palette.${accent}.hex}'><b><u>{}</u></b></span>";
              };
            };
            actions = {
              on-click-right = "mode";
              on-scroll-up = "shift_up";
              on-scroll-down = "shift_down";
            };
          };

          # Audio
          pulseaudio = {
            scroll-step = 2;
            reverse-scrolling = true;
            format = "{icon} {volume}%";
            format-bluetooth = "󰂯 {volume}%";
            format-bluetooth-muted = "󰂲";
            format-muted = "󰝟";
            format-source = "󰍬 {volume}%";
            format-source-muted = "󰍭";
            format-icons = {
              headphone = "󰋋";
              hands-free = "󰋎";
              headset = "󰋎";
              phone = "󰏲";
              portable = "󰏲";
              car = "󰄋";
              default = [ "󰕿" "󰖀" "󰕾" ];
            };
            tooltip-format = ''󰕾 Audio

Output: {desc}
Volume: {volume}%
Source: {format_source}'';
            on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
            on-click-right = "${pkgs.pamixer}/bin/pamixer -t";
            min-length = 6;
          };

          # Memory usage
          "custom/mem" = {
            format = "󰍛 {}";
            interval = 5;
            exec = "free -h | awk '/Mem:/{printf $3}'";
            tooltip = true;
            tooltip-format = "󰍛 Memory Usage";
          };

          # CPU usage
          cpu = {
            interval = 2;
            format = " {usage}%";
            tooltip-format = '' CPU Usage

Total: {usage}%
Per Core: {avg_frequency} GHz avg'';
            min-length = 5;
          };
        };
      };

      style =
        ''
          /* CSS Variables from theme */
          :root {
            --font-family: "${font.mono.name}", "Symbols Nerd Font", sans-serif;
            --font-size: ${toString font.mono.size}px;
          }

          @define-color background #${palette.base00.hex};
          @define-color hover #${palette.base01.hex};
          @define-color black #${palette.base02.hex};
          @define-color text #${palette.base05.hex};
          @define-color active #${palette.${accent}.hex};
          @define-color red #${palette.base08.hex};
          @define-color orange #${palette.base09.hex};
          @define-color yellow #${palette.base0A.hex};
          @define-color green #${palette.base0B.hex};
          @define-color cyan #${palette.base0C.hex};
          @define-color blue #${palette.base0D.hex};
          @define-color magenta #${palette.base0E.hex};
        ''
        + builtins.readFile ./style.css;
    };
  };
}
