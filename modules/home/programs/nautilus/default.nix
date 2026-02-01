{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    host.programs.nautilus.enable = lib.mkEnableOption "Enable Nautilus, a GNOME file manager";
  };

  config = lib.mkIf config.host.programs.nautilus.enable {
    home.packages = with pkgs; [ nautilus ];
  };
}
