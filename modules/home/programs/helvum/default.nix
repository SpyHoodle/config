{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    host.programs.helvum.enable = lib.mkEnableOption "Enable helvum, a pipewire visualisation tool";
  };

  config = lib.mkIf config.host.programs.helvum.enable {
    home.packages = with pkgs; [ helvum ];
  };
}
