{ config, lib, ... }:

let
  palette = config.host.theme.colors.pallete;
  accent = config.host.theme.colors.accent;
  font = config.host.theme.font;
in
{
  options = {
    host.programs.mpv.enable = lib.mkEnableOption "Enable MPV, a video player";
  };

  config = lib.mkIf config.host.programs.mpv.enable {
    programs.mpv = {
      enable = true;
      config = {
        # Playback
        loop-file = "inf";
        keep-open = "yes";
        autofit = "80%x80%";

        # OSD styling with theme
        osd-font = font.sansSerif.name;
        osd-font-size = 32;
        osd-color = "#${palette.base05.hex}";
        osd-border-color = "#${palette.base00.hex}";
        osd-border-size = 2;
        osd-shadow-offset = 1;
        osd-shadow-color = "#${palette.base01.hex}";

        # Subtitle styling with theme
        sub-font = font.sansSerif.name;
        sub-font-size = 40;
        sub-color = "#${palette.base05.hex}";
        sub-border-color = "#${palette.base00.hex}";
        sub-border-size = 2;
        sub-shadow-offset = 1;
        sub-shadow-color = "#${palette.base01.hex}";
        sub-margin-y = 50;

        # Screenshot
        screenshot-format = "png";
        screenshot-high-bit-depth = "yes";
        screenshot-png-compression = 7;
        screenshot-directory = "~/Pictures/Screenshots";
        screenshot-template = "mpv-%F-%P";

        # Performance
        hwdec = "auto-safe";
        vo = "gpu-next";
        gpu-api = "vulkan";
      };

      bindings = {
        # Vim-like navigation
        "l" = "seek 5";
        "h" = "seek -5";
        "j" = "seek -60";
        "k" = "seek 60";
        "L" = "seek 30";
        "H" = "seek -30";

        # Volume
        "=" = "add volume 5";
        "-" = "add volume -5";

        # Speed
        "[" = "multiply speed 0.9";
        "]" = "multiply speed 1.1";
        "{" = "multiply speed 0.5";
        "}" = "multiply speed 2.0";
        "BS" = "set speed 1.0";

        # Subtitles
        "J" = "cycle sub";
        "Alt+j" = "cycle sub down";
      };
    };

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "video/*" = [ "mpv.desktop" ];
        "audio/*" = [ "mpv.desktop" ];
      };
    };
  };
}
