{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    host.programs.xdg-open.enable = lib.mkEnableOption "Whether to enable xdg-open";
  };

  config = lib.mkIf config.host.programs.xdg-open.enable {
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
    };
    environment.systemPackages = [ pkgs.xdg-utils ];
  };
}
