{ inputs, pkgs, config, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

    xwayland.enable = true;
    systemd.enable = true;

    settings =
    let
      mod = "SUPER";
      terminal = "${pkgs.alacritty}/bin/alacritty";
      launcher = "${inputs.anyrun.packages.${pkgs.stdenv.hostPlatform.system}.anyrun}/bin/anyrun";
      browser = "${pkgs.librewolf}/bin/librewolf";
      lock = "${pkgs.hyprlock}/bin/hyprlock --immediate";
      zoom = "${inputs.woomer.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/woomer";
      screenshot = "${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp -d)\" - | ${pkgs.wl-clipboard}/bin/wl-copy";
      system_search = "${terminal} --class systemSearch --title \"System Search\" -e \"zsh nvim $(find $HOME/* -type f | fzf)\"";
      clipboard_history = "${terminal} --class clipse --title \"Clipboard History\" -e ${pkgs.clipse}/bin/clipse";
      powermenu = "${pkgs.wlogout}/bin/wlogout";
    in
    {
      general = {
        "col.active_border" = "rgba(313439ee) rgba(313439ee) 0deg";
        "col.inactive_border" = "rbga(121317ee) rgba(313439ee) 0deg";
      };

      exec-once = [
        "sleep 0.5 && systemctl --user restart xdg-desktop-portal-gtk xdg-desktop-portal-hyprland xdg-desktop-portal pipewire wireplumber"
        "${pkgs.hyprpaper}/bin/hyprpaper"
        "${pkgs.waybar}/bin/waybar"
        "${config.wayland.windowManager.hyprland.package}/bin/hyprctl setcursor macOS 24"
        "${pkgs.clipse}/bin/clipse -listen"
      ];

      input = {
        kb_layout = "gb";
        sensitivity = 0.6;
      };

      animations = {
        enabled = true;
        bezier = "myBezier, 0.645, 0.045, 0.355, 1";

        animation = [
          "windows, 1, 4, myBezier"
          "windowsOut, 1, 4, myBezier"
          "border, 1, 4, default"
          "fade, 1, 4, default"
          "workspaces, 1, 4, myBezier"
        ];
      };

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 3;
        layout = "master";
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      windowrulev2 = [
        "opacity 0.8 0.8,initialTitle:^(wezterm)$"
        "opacity 0.8 0.8,initialTitle:^(Alacritty)$"
        "suppressevent maximize, class:.*"
        "float, class:(clipse)"
        "size 622 652, class:(clipse)"
        "float, class:(systemSearch)"
        "size 622 652, class:(systemSearch)"
      ];

      layerrule = [
        "blur,waybar"
      ];

      decoration = {
        rounding = 0;
        drop_shadow = true;
        shadow_range = 8;
        shadow_offset = "0, 0";
        active_opacity = 1;
        inactive_opacity = 1;
        fullscreen_opacity = 1;
        blur = {
          size = 8;
          passes = 2;
        };
      };
      
      master = {
        mfact = 0.5;
      };

      cursor = {
        no_hardware_cursors = true;
      };

      monitor = [ "DP-1, 2560x1440@144, 0x0, 1" ];

      env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "XDG_SESSION_TYPE,wayland"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "GBM_BACKEND,nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
        "WLR_NO_HARDWARE_CURSORS,1"
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
        ", Print, exec, ${screenshot}"

        # Programs
        "${mod}, RETURN, exec, ${terminal}"
        "${mod} SHIFT, RETURN, bringactivetotop"
        "${mod}, SPACE, exec, ${launcher}"
        "${mod}, D, exec, ${launcher}"
        "${mod}, B, exec, ${browser}"
        "${mod}, Z, exec, ${zoom}"
        "${mod}, X, exec, ${powermenu}"
        ", Insert, exec, ${lock}"

        # Function Keys
        "${mod}, F2, exec, ${clipboard_history}"
        "${mod}, F3, exec, ${system_search}"

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
      ];

      bindm = [
        "${mod}, mouse:272, movewindow"
        "${mod}, mouse:273, resizewindow"
      ];
    };
  };

  home.packages = with pkgs; [
    wl-clipboard
  ];
}
