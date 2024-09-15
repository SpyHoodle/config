{ pkgs, ... }:

{
  services.pcscd.enable = true;
  services.udev.packages = [ pkgs.yubikey-personalization ];
  security.pam = {
    services = {
      login.u2fAuth = true;
      doas.u2fAuth = true;
    };
    yubico = {
      enable = true;
      mode = "challenge-response";
      control = "optional";
    };
  };
}
