{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    host.programs.htop.enable = lib.mkEnableOption "Enable htop, a system monitor tool";
  };

  config = lib.mkIf config.host.programs.htop.enable {
    programs.htop = {
      enable = true;
      package = pkgs.htop-vim;
      settings = {
        hide_kernel_threads = 1;
        hide_userland_threads = 1;
        highlight_base_name = 1;
        show_cpu_usage = 1;
        show_cpu_frequency = 1;
        show_cpu_temperature = 1;
        degree_fahrenheit = 0;
        enable_mouse = 1;
        tree_view = 1;
      };
    };
  };
}
