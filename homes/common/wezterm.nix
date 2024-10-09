{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      return {
        front_end = 'WebGpu',
        color_scheme = 'OneDark (base16)',
        hide_tab_bar_if_only_one_tab = true,
        native_macos_fullscreen_mode = true,
        window_close_confirmation = 'NeverPrompt',
        window_padding = {
          left = 0,
          right = 0,
          top = 0,
          bottom = 0,
        }
      }
    '';
  };
}
