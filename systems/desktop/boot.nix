{ pkgs, ... }:

{
  # Setup bootloader
  boot.loader.systemd-boot = {
    enable = true;
    consoleMode = "max";
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.systemd.enable = true;

  # Enable magic sysrq
  boot.kernel.sysctl."kernel.sysrq" = 502;

  # Kernel settings
  boot.kernelParams = [ "video=2560x1440@180" ];

  # Use the linux-zen kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;
}
