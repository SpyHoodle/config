{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    host.programs.pager.enable = lib.mkEnableOption "Enable the less pager with colours";
  };

  config = lib.mkIf config.host.programs.pager.enable {
    environment.variables.PAGER = "${pkgs.less}/bin/less -R";
  };
}
