{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    host.programs.hyfetch.enable = lib.mkEnableOption "Enable hyfetch, a pride fetch program";
    host.programs.hyfetch.flag = lib.mkOption {
      type = lib.types.enum [
        "transgender"
        "genderfluid"
      ];
      description = "The flag to use for hyfetch";
      default = "transgender";
    };
  };

  config = lib.mkIf config.host.programs.hyfetch.enable {
    home.packages = with pkgs; [ fastfetch ];
    programs.hyfetch = {
      enable = true;
      settings = {
        "preset" = "${config.host.programs.hyfetch.flag}";
        "mode" = "rgb";
        "light_dark" = "dark";
        "lightness" = 0.65;
        "color_align" = {
          "mode" = "horizontal";
          "custom_colors" = [ ];
          "fore_back" = null;
        };
        "backend" = "fastfetch";
        "args" = null;
        "distro" = null;
        "pride_month_shown" = [ ];
        "pride_month_disable" = true;
      };
    };
  };
}
