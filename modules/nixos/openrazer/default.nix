{ config, lib, ... }:

{
  options = {
    host.services.openrazer.enable = lib.mkEnableOption "Whether to enable OpenRazer drivers and userspace daemon";
  };

  config = lib.mkIf config.host.services.openrazer.enable {
    hardware.openrazer = {
      enable = true;
      users = [ config.host.user.name ];
      batteryNotifier = {
        enable = true;
        percentage = 30;
      };
    };
  };
}
