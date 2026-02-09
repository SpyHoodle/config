{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    host.theme.wallpaper = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "Wallpaper of your choosing";
    };
  };

  config = lib.mkIf config.host.desktop.hyprland.enable {
    assertions = [
      {
        assertion = config.host.theme.wallpaper != null;
        message = "host.theme.wallpaper must be set when Hyprland is enabled.";
      }
    ];
    services.hyprpaper = {
      enable = true;
      settings = {
        splash = false;
        wallpaper = [
          {
            monitor = "";
            path = "${config.host.theme.wallpaper}";
          }
        ];
      };
    };
  };
}
