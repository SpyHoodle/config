{ config, lib, ... }:

{
  options = {
    host.theme.wallpaper = lib.mkOption {
      type = lib.types.path;
      description = "Wallpaper of your choosing";
    };
    host.desktop.hyprland.hyprpaper.splash = {
      enable = lib.mkEnableOption "Enable the hyprland splash text";
      offset = lib.mkOption {
        type = lib.types.float;
        description = "Set the splash offset";
        default = 2.0;
      };
    };
  };

  config.xdg.configFile = lib.mkIf config.host.desktop.hyprland.enable {
    "hypr/hyprpaper.conf".source = (
      builtins.toFile "hyprpaper.conf" ''
        preload = ${config.host.theme.wallpaper}

        wallpaper=,${config.host.theme.wallpaper}

        splash = ${if config.host.desktop.hyprland.hyprpaper.splash.enable then "true" else "false"}
        splash_offset = ${builtins.toString config.host.desktop.hyprland.hyprpaper.splash.offset}

        ipc = on
      ''
    );
  };
}
