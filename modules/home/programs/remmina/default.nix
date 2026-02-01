{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    host.programs.remmina.enable = lib.mkEnableOption "Enable Remmina, a remote desktop client";
  };

  config = lib.mkIf config.host.programs.remmina.enable {
    home.packages = with pkgs; [ remmina ];
  };
}
