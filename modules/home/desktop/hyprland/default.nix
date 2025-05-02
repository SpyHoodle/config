{
  inputs,
  pkgs,
  config,
  lib,
  system,
  ...
}:

{
  options = {
    host.desktop.hyprland = {
      enable = lib.mkEnableOption "Use hyprland as your window manager";
      monitors = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        description = "List of default monitors to set";
        default = [ ];
      };
      window = {
        rounding = lib.mkOption {
          type = lib.types.int;
          description = "How round the windows should be";
          default = 13;
        };
        blur = lib.mkOption {
          type = lib.types.int;
          description = "How blurred the wallpaper under innactive windows should be";
          default = 8;
        };
      };
      startupApps = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        description = "List of commands to run on hyprland start";
        default = [ ];
      };
      keybinds = {
        volumeStep = lib.mkOption {
          type = lib.types.int;
          description = "Amount to increase volume by when media keys are pressed in %";
          example = "5";
          default = 5;
        };
        extraBinds =
          let
            binds = lib.types.submodule {
              options = {
                meta = lib.mkOption {
                  type = lib.types.nullOr lib.types.str;
                  description = "Additional modifier keys space seperated";
                  default = null;
                };
                key = lib.mkOption {
                  type = lib.types.str;
                  description = "Final key";
                };
                function = lib.mkOption {
                  type = lib.types.str;
                  description = "Hyprland bind function";
                };
              };
            };
          in
          lib.mkOption {
            type = lib.types.listOf binds;
            description = "Extra keybinds to add";
            default = [ ];
          };
      };
    };
  };

  config = lib.mkIf config.host.desktop.hyprland.enable {
    programs.zsh.profileExtra = lib.mkBefore ''
      if [ -z $WAYLAND_DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
        exec ${pkgs.systemd}/bin/systemd-cat -t hyprland ${pkgs.dbus}/bin/dbus-run-session ${config.wayland.windowManager.hyprland.package}/bin/Hyprland
      fi
    '';

    wayland.windowManager.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${system}.hyprland;

      xwayland.enable = true;
      systemd.enable = true;

      settings =
        let
          mod = "SUPER";
          terminal = if config.host.terminal.alacritty.enable then "${pkgs.alacritty}/bin/alacritty" else "";
          launcher =
            if config.host.desktop.anyrun.enable then
              "${inputs.anyrun.packages.${system}.anyrun}/bin/anyrun"
            else
              "";
          browser =
            if config.host.browser.chromium.enable then
              "${pkgs.chromium}/bin/chromium"
            else
              "${pkgs.firefox}/bin/firefox";
          lock = "${pkgs.hyprlock}/bin/hyprlock --immediate";
          zoom = "${inputs.woomer.packages.${system}.default}/bin/woomer";
          screenshot = "${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp -d)\" - | ${pkgs.wl-clipboard}/bin/wl-copy";
          color_picker = "${pkgs.hyprpicker}/bin/hyprpicker | ${pkgs.wl-clipboard}/bin/wl-copy";
          clipboard_history = "${terminal} --class clipse --title \"Clipboard History\" -e ${pkgs.clipse}/bin/clipse";
          audio_mixer = "${terminal} --class mixer --title \"Audio Mixer\" -e ${pkgs.pulsemixer}/bin/pulsemixer";
          chatgpt = "${pkgs.chromium}/bin/chromium --app=https://chatgpt.com";
          powermenu = "${pkgs.wlogout}/bin/wlogout";
        in
        {
          exec-once = [
            "systemctl --user restart xdg-desktop-portal-gtk xdg-desktop-portal-hyprland xdg-desktop-portal pipewire wireplumber hyprpolkitagent mako kdeconnect"
            "${config.wayland.windowManager.hyprland.package}/bin/hyprctl setcursor ${config.host.theme.cursor.name} ${builtins.toString config.host.theme.cursor.size}"
            "${pkgs.hyprpaper}/bin/hyprpaper"
            "${pkgs.waybar}/bin/waybar"
            "${pkgs.clipse}/bin/clipse -listen"
          ] ++ config.host.desktop.hyprland.startupApps;

          input = {
            kb_layout = "gb";
            sensitivity = 0.6;
          };

          animations = {
            enabled = true;
            bezier = [
              "linear, 0, 0, 1, 1"
              "md3_standard, 0.2, 0, 0, 1"
              "md3_decel, 0.05, 0.7, 0.1, 1"
              "md3_accel, 0.3, 0, 0.8, 0.15"
              "overshot, 0.05, 0.9, 0.1, 1.1"
              "crazyshot, 0.1, 1.5, 0.76, 0.92"
              "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
              "menu_decel, 0.1, 1, 0, 1"
              "menu_accel, 0.38, 0.04, 1, 0.07"
              "easeInOutCirc, 0.85, 0, 0.15, 1"
              "easeOutCirc, 0, 0.55, 0.45, 1"
              "easeOutExpo, 0.16, 1, 0.3, 1"
              "softAcDecel, 0.26, 0.26, 0.15, 1"
              "md2, 0.4, 0, 0.2, 1"
            ];
            animation = [
              "windows, 1, 4, overshot, popin 60%"
              "windowsIn, 1, 4, overshot, popin 60%"
              "windowsOut, 1, 4, overshot, popin 60%"
              "border, 1, 10, default"
              "fade, 1, 3, overshot"
              "layersIn, 1, 3, menu_decel, slide"
              "layersOut, 1, 1.6, menu_accel"
              "fadeLayersIn, 1, 2, menu_decel"
              "fadeLayersOut, 1, 0.5, menu_accel"
              "workspaces, 1, 5, md3_decel, slide"
              "specialWorkspace, 1, 3, md3_decel, slidevert"
            ];
          };

          general = {
            "col.active_border" = "rgba(${
              config.host.theme.colors.pallete.${config.host.theme.colors.accent}.hex
            }FF)";
            "col.inactive_border" = "rgba(${config.host.theme.colors.pallete.base02.hex}FF)";
            gaps_in = 6;
            gaps_out = 12;
            border_size = 2;
            layout = "master";
          };

          misc = {
            disable_hyprland_logo = true;
            disable_splash_rendering = true;
          };

          windowrulev2 = [
            "opacity 0.7 0.7,initialTitle:^(wezterm)$"
            "opacity 0.7 0.7,initialTitle:^(Alacritty)$"
            "suppressevent maximize, class:.*"
            "float, class:(clipse)"
            "float, class:(mixer)"
            "float, class:(xdg-desktop-portal-gtk)"
            "size 900 1000, class:(xdg-desktop-portal-gtk)"
            "size 622 652, class:(clipse)"
            "size 622 652, class:(mixer)"
          ];

          layerrule = [
            "blur,waybar"
          ];

          decoration = {
            rounding = config.host.desktop.hyprland.window.rounding;
            shadow = {
              enabled = true;
              range = 8;
            };
            active_opacity = 1;
            inactive_opacity = 1;
            fullscreen_opacity = 1;
            blur = {
              enabled = true;
              new_optimizations = "on";
              passes = 2;
              size = config.host.desktop.hyprland.window.blur;
            };
          };

          master = {
            mfact = 0.5;
          };

          cursor = {
            no_hardware_cursors = true;
          };

          monitor = config.host.desktop.hyprland.monitors ++ [ ",preferred,auto,1" ];

          env = [
            "XDG_SESSION_TYPE,wayland"
            "XDG_CURRENT_DESKTOP,Hyprland"
            "MOZ_ENABLE_WAYLAND,1"
            "ELECTRON_OZONE_PLATFORM_HINT,auto"
            "NIXOS_OZONE_WL,1"
          ];

          # Keybinds
          bind = [
            "${mod}, Q, killactive"
            "${mod}, F, togglefloating"
            "${mod} SHIFT, R, forcerendererreload"
            "${mod} SHIFT, E, exit"
            "${mod}, M, fullscreen, 0"
            "${mod}, P, pin"
            "${mod} SHIFT, M, fullscreen, 1"

            # Screenshot
            "${mod} SHIFT, S, exec, ${screenshot}"
            "${mod}, S, exec, ${screenshot}"
            ", Print, exec, ${screenshot}"

            # Terminal
            "${mod}, RETURN, exec, ${terminal}"

            # Launcher
            "ALT, SPACE, exec, ${chatgpt}"
            "${mod}, SPACE, exec, ${launcher}"
            "${mod}, D, exec, ${launcher}"

            # Programs
            "${mod}, B, exec, ${browser}"
            #"${mod}, Z, exec, ${zoom}"
            "${mod}, X, exec, ${powermenu}"
            "${mod}, C, exec, ${color_picker}"
            "${mod}, V, exec, ${audio_mixer}"
            ", Insert, exec, ${lock}"

            # Function Keys
            ", F2, exec, ${clipboard_history}"
            ", F8, exec, ${audio_mixer}"
            ", F11, fullscreen, 0"

            # Move focus
            "${mod}, h, movefocus, l"
            "${mod}, j, movefocus, d"
            "${mod}, k, movefocus, u"
            "${mod}, l, movefocus, r"

            # Moving windows
            "${mod} SHIFT, h, movewindow, l"
            "${mod} SHIFT, j, movewindow, d"
            "${mod} SHIFT, k, movewindow, u"
            "${mod} SHIFT, l, movewindow, r"

            # Workspaces
            "${mod}, 1, workspace, 1"
            "${mod}, 2, workspace, 2"
            "${mod}, 3, workspace, 3"
            "${mod}, 4, workspace, 4"
            "${mod}, 5, workspace, 5"
            "${mod}, 6, workspace, 6"
            "${mod}, 7, workspace, 7"
            "${mod}, 8, workspace, 8"
            "${mod}, 9, workspace, 9"
            "${mod}, 0, workspace, 10"

            "${mod} SHIFT, 1, movetoworkspacesilent, 1"
            "${mod} SHIFT, 2, movetoworkspacesilent, 2"
            "${mod} SHIFT, 3, movetoworkspacesilent, 3"
            "${mod} SHIFT, 4, movetoworkspacesilent, 4"
            "${mod} SHIFT, 5, movetoworkspacesilent, 5"
            "${mod} SHIFT, 6, movetoworkspacesilent, 6"
            "${mod} SHIFT, 7, movetoworkspacesilent, 7"
            "${mod} SHIFT, 8, movetoworkspacesilent, 8"
            "${mod} SHIFT, 9, movetoworkspacesilent, 9"
            "${mod} SHIFT, 0, movetoworkspacesilent, 10"

            "${mod}, mouse_right, workspace, e-1"
            "${mod}, mouse_left, workspace, e+1"

            # Volume controls
            ", XF86AudioRaiseVolume, exec, ${pkgs.pamixer}/bin/pamixer -i ${toString config.host.desktop.hyprland.keybinds.volumeStep}"
            ", XF86AudioLowerVolume, exec, ${pkgs.pamixer}/bin/pamixer -d ${toString config.host.desktop.hyprland.keybinds.volumeStep}"
            ", XF86AudioMute, exec, ${pkgs.pamixer}/bin/pamixer -t"

            # Media Controls
            ", XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
            ", XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next"
            ", XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl previous"
          ];

          bindm = [
            "${mod}, mouse:272, movewindow"
            "${mod}, mouse:273, resizewindow"
          ];
        };
    };

    home.packages = with pkgs; [
      wl-clipboard
      hyprpolkitagent
    ];
  };
}
