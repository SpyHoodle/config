{
  config,
  lib,
  pkgs,
  ...
}:

let
  baseSettings = {
    preset = config.host.programs.hyfetch.flag;
    mode = "rgb";
    color_align = {
      mode = "horizontal";
      custom_colors = [ ];
      fore_back = null;
    };
    backend = "fastfetch";
    args = null;
    distro = null;
    pride_month_shown = [ ];
    pride_month_disable = false;
  };

  themedSettings = {
    # Use theme style for light/dark mode
    light_dark = lib.strings.toLower config.host.theme.style;
    lightness = if config.host.theme.style == "Dark" then 0.65 else 0.5;
  };
in
{
  options = {
    host.programs.hyfetch.enable = lib.mkEnableOption "Enable hyfetch, a pride fetch program";
    host.programs.hyfetch.flag = lib.mkOption {
      type = lib.types.enum [
        "transgender"
        "genderfluid"
        "nonbinary"
        "lesbian"
        "gay"
        "bisexual"
        "pansexual"
        "asexual"
        "aromantic"
        "rainbow"
      ];
      description = "The pride flag to use for hyfetch";
      default = "transgender";
    };
  };

  config = lib.mkIf config.host.programs.hyfetch.enable {
    home.packages = with pkgs; [ fastfetch ];
    programs.hyfetch = {
      enable = true;
      settings = lib.mkMerge [
        baseSettings
        (lib.mkIf config.host.theme.enable themedSettings)
      ];
    };
  };
}
