{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    host.programs.btop.enable = lib.mkEnableOption "Enable btop, a system monitor tool";
    host.programs.btop.gpu.enable = lib.mkEnableOption "Enable rocm gpu support";
    host.programs.btop.gpu.name = lib.mkOption {
      type = lib.types.str;
      default = "GPU";
    };
  };

  config = lib.mkIf config.host.programs.btop.enable {
    programs.btop = {
      enable = true;
      package = lib.mkIf config.host.programs.btop.gpu.enable pkgs.btop-rocm;
      settings = {
        color_theme = "TTY";
        theme_background = false;
        truecolor = true;
        show_gpu_info = "Off";
        shown_boxes = "cpu mem net proc gpu0";
        custom_gpu_name0 = config.host.programs.btop.gpu.name;
      };
    };
  };
}
