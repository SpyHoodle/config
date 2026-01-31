{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    host.programs.gamemode.enable = lib.mkEnableOption "Enable GameMode to optimize system performance on demand";
  };

  config = lib.mkIf config.host.programs.gamemode.enable {
    programs.gamemode = {
      enable = true;
      enableRenice = true;
      settings = {
        general = {
          softrealtime = "auto";
          renice = 10;
        };
        custom = {
          start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
          end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
        };
      };
    };
  };
}
