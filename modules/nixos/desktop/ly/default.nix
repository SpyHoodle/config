{ config, lib, ... }:

{
  options = {
    host.desktop.ly.enable = lib.mkEnableOption "Enable ly, a tty display manager";
  };

  config = lib.mkIf config.host.desktop.ly.enable {
    services.displayManager.ly.enable = true;
  };
}
