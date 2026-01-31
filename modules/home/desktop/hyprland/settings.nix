{
  config,
  pkgs,
  lib,
  inputs,
  system,
  ...
}:

let
  lock = "${pkgs.hyprlock}/bin/hyprlock --immediate";
in
{
  config = lib.mkIf config.host.desktop.hyprland.enable {
    programs.zsh.profileExtra = lib.mkBefore ''
      if [ -z $WAYLAND_DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
        exec ${pkgs.systemd}/bin/systemd-cat -t hyprland ${config.wayland.windowManager.hyprland.package}/bin/Hyprland
      fi
    '';

    wayland.windowManager.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${system}.hyprland;

      xwayland.enable = true;
      systemd = {
        enable = true;
        variables = [ "--all" ];
      };

      settings = {
        exec-once = [
          "${pkgs.waybar}/bin/waybar"
          "${pkgs.clipse}/bin/clipse -listen"
          "${config.wayland.windowManager.hyprland.package}/bin/hyprctl setcursor ${config.host.theme.cursor.name} ${builtins.toString config.host.theme.cursor.size}"
        ]
        ++ config.host.desktop.hyprland.startupApps;

        input = {
          kb_layout = config.host.input.keyboard.layout;
          kb_variant = lib.mkIf (
            config.host.input.keyboard.variant != null
          ) config.host.input.keyboard.variant;
          kb_options = lib.mkIf (config.host.input.keyboard.appleMagic.enable) "apple:alupckeys";
          natural_scroll = config.host.input.mouse.scrolling.natural;
          sensitivity = config.host.input.mouse.sensitivity;
          numlock_by_default = true;
          touchpad = {
            natural_scroll = config.host.input.trackpad.scrolling.natural;
            scroll_factor = config.host.input.trackpad.scrolling.factor;
            tap-to-click = config.host.input.trackpad.tapToClick;
            clickfinger_behavior = true;
          };
        };

        gesture = lib.mkIf config.host.input.trackpad.gestures.enable [ "3, horizontal, workspace" ];

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
          no_hardware_cursors = false;
        };

        monitor = config.host.desktop.hyprland.monitors ++ [ ",preferred,auto,1" ];

        env = [
          "XDG_SESSION_TYPE,wayland"
          "XDG_CURRENT_DESKTOP,Hyprland"
          "MOZ_ENABLE_WAYLAND,1"
          "ELECTRON_OZONE_PLATFORM_HINT,auto"
          "NIXOS_OZONE_WL,1"
        ];
      };
    };

    services.fusuma.settings.swipe = lib.mkIf config.host.input.trackpad.gestures.enable (
      let
        hyprctl = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl";
        jq = "${pkgs.jq}/bin/jq";
        awk = "${pkgs.gawk}/bin/awk";
      in
      {
        "3".up.command = "${hyprctl} dispatch fullscreen 0";
        "3".down.command = "${hyprctl} dispatch fullscreen 0";
        "4".down.command = lock;
        "3".left.command =
          "${hyprctl} dispatch workspace $(${hyprctl} activeworkspace -j | ${jq} .id | ${awk} '{print $1+1}')";
        "3".right.command =
          "${hyprctl} dispatch workspace $(${hyprctl} activeworkspace -j | ${jq} .id | ${awk} '{print $1-1}')";
      }
    );

    home.packages = with pkgs; [
      wl-clipboard
      hyprpolkitagent
    ];
  };
}
