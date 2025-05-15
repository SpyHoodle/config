{ lib, config, ... }:

{
  options = {
    host.input.trackpad.gestures.enable = lib.mkEnableOption "Enable trackpad gestures";
  };

  config = lib.mkIf (config.host.input.trackpad.gestures.enable && config.host.desktop.hyprland.enable) {
    services.fusuma.enable = true;
    systemd.user.startServices = "sd-switch";
    systemd.user.services.fusuma.Unit.X-Restart-Triggers = [
      config.xdg.configFile."fusuma/config.yml".source
    ];
  };
}
