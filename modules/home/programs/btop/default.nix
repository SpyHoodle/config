{
  config,
  lib,
  pkgs,
  ...
}:

let
  palette = config.host.theme.colors.pallete;
  # Generate a custom btop theme from our color palette
  btopTheme = pkgs.writeText "custom.theme" ''
    # Theme generated from host.theme colors
    theme[main_bg]="#${palette.base00.hex}"
    theme[main_fg]="#${palette.base05.hex}"
    theme[title]="#${palette.base05.hex}"
    theme[hi_fg]="#${palette.${config.host.theme.colors.accent}.hex}"
    theme[selected_bg]="#${palette.base02.hex}"
    theme[selected_fg]="#${palette.base05.hex}"
    theme[inactive_fg]="#${palette.base04.hex}"
    theme[graph_text]="#${palette.base05.hex}"
    theme[meter_bg]="#${palette.base02.hex}"
    theme[proc_misc]="#${palette.base0C.hex}"
    theme[cpu_box]="#${palette.base0D.hex}"
    theme[mem_box]="#${palette.base0B.hex}"
    theme[net_box]="#${palette.base0E.hex}"
    theme[proc_box]="#${palette.base0C.hex}"
    theme[div_line]="#${palette.base03.hex}"
    theme[temp_start]="#${palette.base0B.hex}"
    theme[temp_mid]="#${palette.base0A.hex}"
    theme[temp_end]="#${palette.base08.hex}"
    theme[cpu_start]="#${palette.base0B.hex}"
    theme[cpu_mid]="#${palette.base0A.hex}"
    theme[cpu_end]="#${palette.base08.hex}"
    theme[free_start]="#${palette.base0E.hex}"
    theme[free_mid]="#${palette.base0D.hex}"
    theme[free_end]="#${palette.base0C.hex}"
    theme[cached_start]="#${palette.base0D.hex}"
    theme[cached_mid]="#${palette.base0C.hex}"
    theme[cached_end]="#${palette.base0B.hex}"
    theme[available_start]="#${palette.base09.hex}"
    theme[available_mid]="#${palette.base0A.hex}"
    theme[available_end]="#${palette.base0B.hex}"
    theme[used_start]="#${palette.base08.hex}"
    theme[used_mid]="#${palette.base09.hex}"
    theme[used_end]="#${palette.base0A.hex}"
    theme[download_start]="#${palette.base0B.hex}"
    theme[download_mid]="#${palette.base0C.hex}"
    theme[download_end]="#${palette.base0D.hex}"
    theme[upload_start]="#${palette.base0E.hex}"
    theme[upload_mid]="#${palette.base08.hex}"
    theme[upload_end]="#${palette.base09.hex}"
    theme[process_start]="#${palette.base0C.hex}"
    theme[process_mid]="#${palette.base0D.hex}"
    theme[process_end]="#${palette.base0E.hex}"
  '';
in
{
  options = {
    host.programs.btop.enable = lib.mkEnableOption "Enable btop, a system monitor tool";
    host.programs.btop.gpu.enable = lib.mkEnableOption "Enable rocm gpu support";
    host.programs.btop.gpu.name = lib.mkOption {
      type = lib.types.str;
      default = "GPU";
      description = "Custom name for the GPU in btop display";
    };
  };

  config = lib.mkIf config.host.programs.btop.enable {
    # Link the custom theme
    xdg.configFile."btop/themes/custom.theme".source = btopTheme;

    programs.btop = {
      enable = true;
      package = lib.mkIf config.host.programs.btop.gpu.enable pkgs.btop-rocm;
      settings = {
        color_theme = "custom";
        theme_background = false;
        truecolor = true;
        force_tty = false;
        vim_keys = true;
        rounded_corners = true;
        graph_symbol = "braille";
        shown_boxes = "cpu mem net proc" + lib.optionalString config.host.programs.btop.gpu.enable " gpu0";
        update_ms = 1000;
        proc_tree = true;
        proc_sorting = "cpu lazy";
        show_gpu_info = lib.mkIf config.host.programs.btop.gpu.enable "On";
        custom_gpu_name0 = lib.mkIf config.host.programs.btop.gpu.enable config.host.programs.btop.gpu.name;
      };
    };
  };
}
