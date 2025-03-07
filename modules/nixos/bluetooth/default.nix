{ lib, config, ... }:

{
  options = {
    host.bluetooth.enable = lib.mkEnableOption "Enable Bluetooth support";
  };

  config = lib.mkIf config.host.bluetooth.enable {
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    services.blueman.enable = true;
  };
}
