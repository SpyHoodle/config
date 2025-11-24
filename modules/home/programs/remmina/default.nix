{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    host.programs.remmina.enable = lib.mkEnableOption {
      description = "Enable Remmina, a remote desktop";
      default = false;
    };
  };

  config = lib.mkIf config.host.programs.remmina.enable {
    home.packages = with pkgs; [ remmina ];
  };
}
