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

  config.xdg.configFile = lib.mkIf config.host.desktop.hyprland.enable {
    "hypr/hyprpaper.conf".text =
      let
        wallpaper = "${config.host.theme.wallpaper}";
        monitors = config.host.desktop.hyprland.monitors;
        wallpaperLines = builtins.concatStringsSep "\n" (
          builtins.map (m:
            let
              monitorName = builtins.head (lib.splitString "," m);
            in
            "wallpaper = ${monitorName},${wallpaper}"
          ) monitors
        );
      in
      ''
        preload = ${wallpaper}
        ${wallpaperLines}
        splash = false
        ipc = on
      '';

    home.packages = [ pkgs.hyprpaper ];
  };
}
