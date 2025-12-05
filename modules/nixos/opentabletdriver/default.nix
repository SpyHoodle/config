{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.host.services.opentabletdriver.enable =
    lib.mkEnableOption "Enable OpenTabletDriver, a driver for drawing tablets";

  config = lib.mkIf config.host.services.opentabletdriver.enable {
    hardware.opentabletdriver.enable = true;
    hardware.opentabletdriver.daemon.enable = true;
    environment.systemPackages = with pkgs; [
      opentabletdriver
    ];
  };
}
