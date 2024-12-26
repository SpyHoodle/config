{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    host.services.openrgb.enable = lib.mkEnableOption "Enable OpenRGB service, a program to control RGB lighting";
  };

  config = lib.mkIf config.host.services.openrgb.enable {
    services.hardware.openrgb.enable = true;
    environment.systemPackages = with pkgs; [ openrgb-with-all-plugins ];
  };
}
