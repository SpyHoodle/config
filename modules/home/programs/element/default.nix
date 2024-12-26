{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    host.programs.element.enable = lib.mkEnableOption "Enable Element, a chat application";
  };

  config = lib.mkIf config.host.programs.element.enable {
    home.packages = with pkgs; [ element-desktop ];
  };
}
