{ config,
  lib,
  pkgs,
  inputs,
  system,
  ... }:

let
  mod = "SUPER";
  terminal =
    if config.host.terminal.alacritty.enable then "${pkgs.alacritty}/bin/alacritty" else "";
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
  kill = "${pkgs.hyprland}/bin/hyprctl kill";
  screenshot = "${pkgs.hyprshot}/bin/hyprshot -m region --clipboard-only";
  screenshot_window = "${pkgs.hyprshot}/bin/hyprshot -m window --clipboard-only";
  screenshot_output = "${pkgs.hyprshot}/bin/hyprshot -m output --clipboard-only";
  color_picker = "${pkgs.hyprpicker}/bin/hyprpicker | ${pkgs.wl-clipboard}/bin/wl-copy";
  clipboard_history = "${terminal} --class clipse --title \"Clipboard History\" -e ${pkgs.clipse}/bin/clipse";
  audio_mixer = "${terminal} --class mixer --title \"Audio Mixer\" -e ${pkgs.pulsemixer}/bin/pulsemixer";
  chatgpt = "${pkgs.chromium}/bin/chromium --app=https://chatgpt.com";
  powermenu = "${pkgs.wlogout}/bin/wlogout";
  logout = "${pkgs.systemd}/bin/systemctl --user exit && ${pkgs.systemd}/bin/loginctl terminate-user ${toString config.host.home-manager.username}";
in
{
  config = lib.mkIf config.host.desktop.hyprland.enable {
    wayland.windowManager.hyprland.settings = {
      bind = [
        "${mod}, Q, killactive"
        "${mod}, F, togglefloating"
        "${mod} SHIFT, R, forcerendererreload"
        "${mod} SHIFT, E, exit"
        "${mod}, E, exec, ${logout}"
        "${mod}, M, fullscreen, 0"
        "${mod}, P, pin"
        "${mod} SHIFT, M, fullscreen, 1"

        # Screenshot
        "${mod} SHIFT, S, exec, ${screenshot}"
        "${mod}, S, exec, ${screenshot}"
        ", Print, exec, ${screenshot_output}"
        "${mod} ALT, S, exec, ${screenshot_window}"

        # Terminal
        "${mod}, RETURN, exec, ${terminal}"

        # Launcher
        "ALT, SPACE, exec, ${chatgpt}"
        "${mod}, SPACE, exec, ${launcher}"
        "${mod}, D, exec, ${launcher}"

        # Programs
        "${mod}, B, exec, ${browser}"
        "${mod}, Z, exec, ${powermenu}"
        "${mod}, X, exec, ${kill}"
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
}
