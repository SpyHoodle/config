{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    host.boot.systemd.enable = lib.mkEnableOption "Enable the systemd-boot bootloader";
    host.boot.sysrq.enable = lib.mkEnableOption "Enable the sysrq key functions";
    host.boot.linuxZen.enable = lib.mkEnableOption "Use the linux-zen kernel, a more optimised linux kernel";
    host.boot.kernelParams = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = "Parameters added to the kernel command line";
    };
  };

  config = {
    boot.loader.systemd-boot = lib.mkIf config.host.boot.systemd.enable {
      enable = true;
      editor = false;
      configurationLimit = 10;
    };
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernel.sysctl."kernel.sysrq" = lib.mkIf config.host.boot.sysrq.enable 502;
    boot.kernelPackages = lib.mkIf config.host.boot.linuxZen.enable pkgs.linuxPackages_zen;
    boot.kernelParams = config.host.boot.kernelParams;
  };
}
