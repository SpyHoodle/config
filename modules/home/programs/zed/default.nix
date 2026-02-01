{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    host.programs.zed.enable = lib.mkEnableOption "Enable Zed, a fast code editor";
  };

  config = lib.mkIf config.host.programs.zed.enable {
    home.packages = [ pkgs.zed-editor ];
  };
}
