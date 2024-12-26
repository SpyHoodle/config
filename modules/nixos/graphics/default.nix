{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    host.graphics.enable = lib.mkEnableOption "Enable reccommended graphics settings";
  };

  config = lib.mkIf config.host.graphics.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = [ pkgs.vaapiVdpau ];
    };
  };
}
