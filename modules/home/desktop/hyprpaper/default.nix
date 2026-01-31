{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    host.theme.wallpaper = lib.mkOption {
      type = lib.types.path;
      description = "Wallpaper of your choosing";
    };
  };

  config = lib.mkIf config.host.desktop.hyprland.enable {
    services.hyprpaper = {
      enable = true;
      settings = {
        splash = false;
        wallpaper = [
          {
            monitor = "DP-1";
            path = "${config.host.theme.wallpaper}";
          }
          {
            monitor = "DP-2";
            path = "${config.host.theme.wallpaper}";
          }
        ];
      };
    };
  };
}
