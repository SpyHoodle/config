{
  lib,
  config,
  ...
}:

{
  options = {
    host.programs.sudo.idAuth.enable = lib.mkEnableOption "Enable Touch & Watch ID for sudo";
  };

  config = lib.mkIf config.host.programs.shell.zsh.enable {
    security.pam.services.sudo_local.touchIdAuth = true;
    security.pam.services.sudo_local.watchIdAuth = true;
  };
}
