{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    host.programs.ncdu.enable = lib.mkEnableOption "Enable ncdu, a system storage visualisation tool";
  };

  config = lib.mkIf config.host.programs.ncdu.enable {
    home.packages = with pkgs; [ ncdu ];
  };
}
