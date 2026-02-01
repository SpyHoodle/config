{
  config,
  lib,
  ...
}:

let
  palette = config.host.theme.colors.pallete;
in
{
  options = {
    host.programs.cava.enable = lib.mkEnableOption "Enable cava, a CLI audio visualisation program";
  };

  config = lib.mkIf config.host.programs.cava.enable {
    programs.cava = {
      enable = true;
      settings = {
        general = {
          framerate = 60;
          autosens = 1;
          bars = 0; # 0 = auto
          bar_width = 2;
          bar_spacing = 1;
        };
        smoothing = {
          noise_reduction = 77;
        };
        color = {
          # Use theme colors for gradient
          gradient = 1;
          gradient_count = 6;
          gradient_color_1 = "'#${palette.base0D.hex}'"; # Blue
          gradient_color_2 = "'#${palette.base0C.hex}'"; # Cyan
          gradient_color_3 = "'#${palette.base0B.hex}'"; # Green
          gradient_color_4 = "'#${palette.base0A.hex}'"; # Yellow
          gradient_color_5 = "'#${palette.base09.hex}'"; # Orange
          gradient_color_6 = "'#${palette.base08.hex}'"; # Red
        };
      };
    };
  };
}
