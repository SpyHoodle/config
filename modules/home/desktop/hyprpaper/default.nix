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
        preload = [ "${config.host.theme.wallpaper}" ];
        wallpaper =
          if config.host.desktop.hyprland.monitors != [ ] then
            builtins.map (m:
              let
                monitorName = builtins.head (lib.splitString "," m);
              in
              "${monitorName},${config.host.theme.wallpaper}"
            ) config.host.desktop.hyprland.monitors
          else
            [ ",${config.host.theme.wallpaper}" ];
      };
    };
  };
}
