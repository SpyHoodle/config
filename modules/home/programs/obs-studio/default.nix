{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    host.programs.obs-studio.enable = lib.mkEnableOption "Enable obs-studio, a video recording and streaming software";
  };

  config = lib.mkIf config.host.programs.ncdu.enable {
    programs.obs-studio.enable = true;
  };
}
