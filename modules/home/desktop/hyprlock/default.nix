{ config, lib, ... }:

{
  options = {
    host.desktop.hyprlock.enable = lib.mkEnableOption "Enable hyprlock, a hyprland screen locker";
  };

  config = lib.mkIf config.host.desktop.hyprlock.enable {
    programs.hyprlock = {
      enable = true;
      settings = {
        general = {
          disable_loading_bar = true;
          grace = 300;
          hide_cursor = true;
          no_fade_in = false;
        };

        background = [
          {
            path = builtins.toString config.host.theme.wallpaper;
            blur_passes = 3;
            blur_size = 8;
          }
        ];

        input-field = [
          {
            placeholder_text = "";
            size = "300, 70";
            rounding = -1;
            position = "0, 0";
            monitor = "DP-1";
            dots_center = true;
            fade_on_empty = false;
            font_color = "#${config.host.theme.colors.pallete.${config.host.theme.colors.accent}.hex}";
            fail_color = "#${config.host.theme.colors.pallete.base08.hex}";
            inner_color = "#${config.host.theme.colors.pallete.base00.hex}";
            outer_color = "#${config.host.theme.colors.pallete.${config.host.theme.colors.accent}.hex}";
            outline_thickness = 3;
            shadow_passes = 2;
          }
        ];
      };
    };
  };
}
