{ config, lib, ... }:

{
  options = {
    host.programs.mpv.enable = lib.mkEnableOption "Enable MPV, a video player";
  };

  config = lib.mkIf config.host.programs.mpv.enable {
    programs.mpv = {
      enable = true;
      config = {
        loop-file = "inf";
      };
    };
    home.shellAliases = {
      mpv = "mpv --osd-font='${config.host.theme.font.sansSerif.name}'";
    };
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "video/*" = [ "mpv.desktop" ];
      };
    };
  };
}
