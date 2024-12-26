{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    host.services.gnupg.enable = lib.mkEnableOption "Enable the GPG agent";
  };

  config = lib.mkIf config.host.services.gnupg.enable {
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = false;
      pinentryPackage = pkgs.pinentry-gnome3;
    };
  };
}
