{ config, lib, ... }:

{
  options = {
    host.networking.avahi.enable = lib.mkEnableOption "Enable Avahi discovery and recommended settings";
  };

  config = lib.mkIf config.host.networking.avahi.enable {
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      nssmdns6 = true;
      ipv4 = true;
      ipv6 = true;
      publish = {
        enable = true;
        addresses = true;
        workstation = true;
        userServices = true;
      };
    };
  };
}
