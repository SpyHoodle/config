{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    host.programs.kdeconnect.enable = lib.mkEnableOption "Enable kdeconnect, a tool for talking to devices";
  };

  config = lib.mkIf config.host.programs.kdeconnect.enable {
    services.kdeconnect = {
      enable = true;
      indicator = true;
    };
  };
}
