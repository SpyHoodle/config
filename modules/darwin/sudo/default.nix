{
  lib,
  config,
  ...
}:

{
  options = {
    host.programs.sudo.touchId.enable = lib.mkEnableOption "Enable Touch ID for sudo";
  };

  config = lib.mkIf config.host.programs.shell.zsh.enable {
    security.pam.enableSudoTouchIdAuth = true;
  };
}
