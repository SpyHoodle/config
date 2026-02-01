{ config, lib, ... }:

{
  options = {
    host.services.coolercontrol.enable = lib.mkEnableOption "Enable CoolerControl, a service for managing system cooling";
  };

  config = lib.mkIf config.host.services.coolercontrol.enable {
    programs.coolercontrol.enable = true;
    boot.kernelParams = [
      "amdgpu.ppfeaturemask=0xffffffff"
    ];
  };
}
