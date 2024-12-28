{
  config,
  lib,
  ...
}:

{
  options = {
    host.programs.cava.enable = lib.mkEnableOption "Enable cava, a cli audio visualisation program";
  };

  config = lib.mkIf config.host.programs.cava.enable {
    programs.cava.enable = true;
  };
}
