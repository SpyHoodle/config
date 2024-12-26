{ config, lib, ... }:

{
  options = {
    host.yubikey.enable = lib.mkEnableOption "Enable system YubiKey support";
    host.yubikey.pam.enable = lib.mkEnableOption "Enable login and doas with YubiKey";
  };

  config = lib.mkIf config.host.yubikey.enable {
    services.pcscd.enable = true;
    security.pam.u2f.settings.cue = true;
    security.pam.services = lib.mkIf config.host.yubikey.pam.enable {
      login.u2fAuth = true;
      doas.u2fAuth = true;
    };
  };
}
