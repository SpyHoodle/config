{ config, lib, ... }:

{
  options = {
    host.desktop.mako.enable = lib.mkEnableOption "Whether to use mako to handle notifications";
  };

  config = lib.mkIf config.host.desktop.mako.enable {
    services.mako = {
      enable = true;
      settings = {
        icons = true;
        margin = "12,12,12";
        borderRadius = config.host.desktop.hyprland.window.rounding;
        borderSize = 2;
        width = 400;
        height = 100;
        font = "${config.host.theme.font.sansSerif.name} ${
          builtins.toString (config.host.theme.font.sansSerif.size - 2)
        }";
        textColor = "#${config.host.theme.colors.pallete.base05.hex}";
        backgroundColor = "#${config.host.theme.colors.pallete.base00.hex}";
        borderColor = "#${config.host.theme.colors.pallete.${config.host.theme.colors.accent}.hex}";
        progressColor = "#${config.host.theme.colors.pallete.${config.host.theme.colors.accent}.hex}";
      };
    };
  };
}
