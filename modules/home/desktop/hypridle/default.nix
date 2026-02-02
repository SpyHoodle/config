{ config, lib, pkgs, ... }:

{
  options = {
    host.desktop.hyprland.hypridle.enable = lib.mkEnableOption "Enable Hypridle, Hyprland's idle daemon";
  };

  config = lib.mkIf config.host.desktop.hyprland.hypridle.enable {
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          after_sleep_cmd = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl dispatch dpms on";
          ignore_dbus_inhibit = false;
          lock_cmd = "${config.wayland.windowManager.hyprland.package}/bin/hyprlock --immediate";
        };

        listener = [
          {
            timeout = 900;
            on-timeout = "${config.wayland.windowManager.hyprland.package}/bin/hyprlock --immediate";
          }
        ];
      };
    };
  };
}
