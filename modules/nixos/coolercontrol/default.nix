{ config, lib, ... }:

{
  options = {
    host.programs.coolercontrol.enable = lib.mkEnableOption "Enable coolercontrol, a service for managing system cooling";
  };

  config = lib.mkIf config.host.programs.coolercontrol.enable {
    programs.coolercontrol.enable = true;
    boot.kernelParams = [
      "amdgpu.ppfeaturemask=0xffffffff"
    ];
  };
}
