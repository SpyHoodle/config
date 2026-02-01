{
  config,
  lib,
  pkgs,
  ...
}:

let
  palette = config.host.theme.colors.pallete;
  accent = config.host.theme.colors.accent;
  isDark = config.host.theme.style == "Dark";
in
{
  options = {
    host.programs.zathura.enable = lib.mkEnableOption "Enable zathura, a document viewer";
  };

  config = lib.mkIf config.host.programs.zathura.enable {
    programs.zathura = {
      enable = true;
      options = {
        # Font from theme
        font = "${config.host.theme.font.mono.name} ${toString config.host.theme.font.mono.size}";

        # Colors from theme palette
        default-bg = "#${palette.base00.hex}";
        default-fg = "#${palette.base05.hex}";

        statusbar-bg = "#${palette.base01.hex}";
        statusbar-fg = "#${palette.base05.hex}";

        inputbar-bg = "#${palette.base00.hex}";
        inputbar-fg = "#${palette.base05.hex}";

        notification-bg = "#${palette.base00.hex}";
        notification-fg = "#${palette.base05.hex}";
        notification-error-bg = "#${palette.base08.hex}";
        notification-error-fg = "#${palette.base00.hex}";
        notification-warning-bg = "#${palette.base09.hex}";
        notification-warning-fg = "#${palette.base00.hex}";

        highlight-color = "rgba(${toString palette.base0A.rgb.r},${toString palette.base0A.rgb.g},${toString palette.base0A.rgb.b},0.5)";
        highlight-active-color = "rgba(${toString palette.${accent}.rgb.r},${toString palette.${accent}.rgb.g},${toString palette.${accent}.rgb.b},0.5)";

        completion-bg = "#${palette.base01.hex}";
        completion-fg = "#${palette.base05.hex}";
        completion-highlight-bg = "#${palette.${accent}.hex}";
        completion-highlight-fg = "#${palette.base00.hex}";
        completion-group-bg = "#${palette.base02.hex}";
        completion-group-fg = "#${palette.base05.hex}";

        index-bg = "#${palette.base00.hex}";
        index-fg = "#${palette.base05.hex}";
        index-active-bg = "#${palette.${accent}.hex}";
        index-active-fg = "#${palette.base00.hex}";

        # Recolor document (invert for dark mode)
        recolor = isDark;
        recolor-darkcolor = "#${palette.base05.hex}";
        recolor-lightcolor = "#${palette.base00.hex}";
        recolor-keephue = true;
        recolor-reverse-video = true;

        # UI settings
        selection-clipboard = "clipboard";
        adjust-open = "best-fit";
        pages-per-row = 1;
        scroll-page-aware = true;
        scroll-full-overlap = "0.01";
        scroll-step = 50;
        zoom-min = 10;
        guioptions = ""; # Hide GUI elements for cleaner look

        # Sandbox for security
        sandbox = "normal";
      };

      mappings = {
        # Vim-like navigation
        "<C-d>" = "scroll half-down";
        "<C-u>" = "scroll half-up";
        "D" = "toggle_page_mode";
        "r" = "reload";
        "R" = "rotate";
        "K" = "zoom in";
        "J" = "zoom out";
        "i" = "recolor";
        "p" = "print";
      };
    };

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = [
          "org.pwmt.zathura-pdf-mupdf.desktop"
          "org.pwmt.zathura.desktop"
        ];
        "application/epub+zip" = [ "org.pwmt.zathura.desktop" ];
      };
    };
  };
}
