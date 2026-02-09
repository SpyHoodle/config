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

  # Theme settings for consistent styling
  rounding = builtins.toString config.host.theme.desktop.borders.rounding;
  gaps_out = builtins.toString config.host.theme.desktop.gaps.outer;
  gaps_in = builtins.toString config.host.theme.desktop.gaps.inner;
  border_size = builtins.toString config.host.theme.desktop.borders.size;
  windowModule = "hyprland/window";
  selectedNetworkModule = "network#${config.host.desktop.waybar.modules.network}";
  modulesLeft =
    [ "hyprland/workspaces" ]
    ++ lib.optionals (config.host.desktop.waybar.modules.window.position == "left") [ windowModule ];
  modulesCenter = lib.optionals (config.host.desktop.waybar.modules.window.position == "center") [ windowModule ];
in
{
  options = {
    host.desktop.waybar.enable = lib.mkEnableOption "Use waybar as your top bar";
    host.desktop.waybar.modules.network = lib.mkOption {
      type = lib.types.enum [
        "wifi"
        "ethernet"
      ];
      default = "wifi";
      description = "Primary network module shown in Waybar.";
    };
    host.desktop.waybar.modules.window.position = lib.mkOption {
      type = lib.types.enum [
        "center"
        "left"
      ];
      default = "center";
      description = "Position for the hyprland window title module.";
    };
  };

  config = lib.mkIf config.host.desktop.waybar.enable {
    programs.waybar = {
      enable = true;

      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          margin = "${gaps_out} ${gaps_out} 0 ${gaps_out}";
          modules-left = modulesLeft;
          modules-center = modulesCenter;
          modules-right = [
            "tray"
            "privacy"
            "pulseaudio"
            "temperature"
            "cpu"
            "custom/mem"
            "disk"
            selectedNetworkModule
            "network#tailscale"
            "clock"
          ];

          # Window title
          "hyprland/window" = {
            icon = true;
            icon-size = 18;
            max-length = 50;
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
            format = "  {percentage_used}%";
            path = "/";
            tooltip-format = "  Storage\n\nUsed: {used} / {total}\nFree: {free} ({percentage_free}% available)";            states = {
              good = 0;
              warning = 70;
              critical = 90;
            };          };

          # Temperature
          temperature = {
            thermal-zone = 2;
            critical-threshold = 80;            warning-threshold = 60;            format = "  {temperatureC}°C";
            format-critical = "  {temperatureC}°C";
            tooltip-format = "  CPU Temperature\n\n{temperatureC}°C / {temperatureF}°F";
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
            format = " ";
            format-ethernet = " ";
            format-wifi = " ";
            format-disconnected = " ";
            format-disabled = " ";
            interval = 5;
            tooltip-format-wifi = ''  WiFi Connected

SSID: {essid}
Interface: {ifname}
Signal: {signalStrength}% ({signaldBm} dBm)
Frequency: {frequency} MHz
IP: {ipaddr}/{cidr}
Gateway: {gwaddr}
↑ {bandwidthUpBytes}  ↓ {bandwidthDownBytes}'';
            tooltip-format-ethernet = ''  Ethernet Connected

Interface: {ifname}
IP: {ipaddr}/{cidr}
Gateway: {gwaddr}
↑ {bandwidthUpBytes}  ↓ {bandwidthDownBytes}'';
            tooltip-format-disconnected = "  Network Disconnected";
            max-length = 50;
            min-length = 1;
            on-click = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
          };

          "network#ethernet" = {
            interface = "en*";
            format = " ";
            format-ethernet = " ";
            format-disconnected = " ";
            format-disabled = " ";
            interval = 5;
            tooltip-format-ethernet = ''  Ethernet Connected

Interface: {ifname}
IP: {ipaddr}/{cidr}
Gateway: {gwaddr}
↑ {bandwidthUpBytes}  ↓ {bandwidthDownBytes}'';
            tooltip-format-disconnected = "  Ethernet Disconnected";
            max-length = 50;
            min-length = 1;
            on-click = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
          };

          # Tailscale VPN
          "network#tailscale" = {
            interface = "tailscale0";
            interval = 5;
            format = " ";
            format-ethernet = " ";
            format-disconnected = " ";
            tooltip-format-ethernet = ''  Tailscale Connected

Interface: {ifname}
IP: {ipaddr}/{cidr}
↑ {bandwidthUpBytes}  ↓ {bandwidthDownBytes}'';
            tooltip-format-disconnected = "  Tailscale Disconnected";
            max-length = 50;
            min-length = 1;
          };

          # Clock
          clock = {
            interval = 1;
            format = "  {:%H:%M:%S}";
            format-alt = "  {:%a %d %b %Y, %H:%M:%S}";
            tooltip-format = ''<tt><small>{calendar}</small></tt>'';
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
            tooltip-format = ''󰕾  Audio

Output: {desc}
Volume: {volume}%
Source: {format_source}'';
            on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
            on-click-right = "${pkgs.pamixer}/bin/pamixer -t";
            min-length = 13;
          };

          # Memory usage
          "custom/mem" = {
            format = "  {}";
            interval = 5;
            exec = "free -h | awk '/Mem:/{printf $3}'";
            tooltip = true;
            tooltip-format = "  Memory Usage";
          };

          # CPU usage
          cpu = {
            interval = 2;
            format = "  {usage}%";
            tooltip-format = ''  CPU Usage

Total: {usage}%
Per Core: {avg_frequency} GHz avg'';
            min-length = 5;
          };
        };
      };

      style =
        ''
          /* Theme colors from Nix */
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

          /* Base styles - rounding and border from Hyprland */
          * {
            font-family: "${font.mono.name}", monospace;
            font-size: 17px;
            font-weight: normal;
            min-height: 0;
            border-radius: ${rounding}px;
            border-width: ${border_size}px;
          }

          /* Workspace button margins to overlap with container border */
          #workspaces button {
            margin: -${border_size}px;
            border-width: ${border_size}px;
          }
          #workspaces button:first-child {
            margin-left: -${border_size}px;
          }
          #workspaces button:last-child {
            margin-right: -${border_size}px;
          }
        ''
        + builtins.readFile ./style.css;
    };
  };
}
