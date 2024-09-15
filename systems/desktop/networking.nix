{ lib, ... }:

{
  # DHCP
  networking.useDHCP = lib.mkDefault true;

  # Hostname
  networking.hostName = "desktop";

  # Enable wireless support & configuration
  networking.wireless.enable = false;
}
