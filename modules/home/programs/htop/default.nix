{
  config,
  lib,
  pkgs,
  ...
}:

let
  baseSettings = {
    # UI settings
    hide_kernel_threads = 1;
    hide_userland_threads = 1;
    highlight_base_name = 1;
    highlight_megabytes = 1;
    highlight_threads = 1;
    highlight_changes = 1;
    highlight_changes_delay_secs = 3;

    # CPU settings
    show_cpu_usage = 1;
    show_cpu_frequency = 1;
    show_cpu_temperature = 1;
    degree_fahrenheit = 0;
    cpu_count_from_one = 0;
    detailed_cpu_time = 0;

    # Display settings
    enable_mouse = 1;
    tree_view = 1;
    tree_sort_direction = 1;
    sort_direction = 1;
    sort_key = 46; # PERCENT_CPU

    # Header layout
    header_margin = 1;
    hide_function_bar = 0;
  };

  themedSettings = {
    # Use theme colors
    color_scheme = if config.host.theme.style == "Dark" then 0 else 5;
  };
in
{
  options = {
    host.programs.htop.enable = lib.mkEnableOption "Enable htop, a system monitor tool";
  };

  config = lib.mkIf config.host.programs.htop.enable {
    programs.htop = {
      enable = true;
      package = pkgs.htop-vim;
      settings = lib.mkMerge [
        baseSettings
        (lib.mkIf config.host.theme.enable themedSettings)
      ];
    };
  };
}
