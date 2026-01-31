{ config, lib, ... }:

{
  options = {
    host.terminal.alacritty.enable = lib.mkEnableOption "Enable Alacritty terminal emulator";
    host.terminal.alacritty.defaultTerminal = lib.mkEnableOption "Set Alacritty as the default terminal emulator";
  };

  config = lib.mkIf config.host.terminal.alacritty.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        window = {
          decorations = "none";
          dynamic_padding = true;
          padding = {
            x = 0;
            y = 0;
          };
          startup_mode = "Maximized";
        };

        font = {
          normal.family = "${config.host.theme.font.mono.name}";
          bold.family = "${config.host.theme.font.mono.name}";
          italic.family = "${config.host.theme.font.mono.name}";
          size = config.host.theme.font.mono.size;
        };
        scrolling.history = 10000;

        colors.draw_bold_text_with_bright_colors = false;
        window.opacity = 0.9;

        general.import = [
          "${builtins.toFile "theme.toml" ''
            # Default colors
            [colors.primary]
            background = '#${config.host.theme.colors.pallete.base00.hex}'
            foreground = '#${config.host.theme.colors.pallete.base05.hex}'

            # Normal colors
            [colors.normal]
            black   = '#${config.host.theme.colors.pallete.base00.hex}'
            red     = '#${config.host.theme.colors.pallete.base08.hex}'
            green   = '#${config.host.theme.colors.pallete.base0B.hex}'
            yellow  = '#${config.host.theme.colors.pallete.base0A.hex}'
            blue    = '#${config.host.theme.colors.pallete.base0D.hex}'
            magenta = '#${config.host.theme.colors.pallete.base0E.hex}'
            cyan    = '#${config.host.theme.colors.pallete.base0C.hex}'
            white   = '#${config.host.theme.colors.pallete.base05.hex}'

            # Bright colors
            [colors.bright]
            black   = '#${config.host.theme.colors.pallete.base04.hex}'
            red     = '#${config.host.theme.colors.pallete.base08.hex}'
            green   = '#${config.host.theme.colors.pallete.base0B.hex}'
            yellow  = '#${config.host.theme.colors.pallete.base0A.hex}'
            blue    = '#${config.host.theme.colors.pallete.base0D.hex}'
            magenta = '#${config.host.theme.colors.pallete.base0E.hex}'
            cyan    = '#${config.host.theme.colors.pallete.base0C.hex}'
            white   = '#${config.host.theme.colors.pallete.base05.hex}'
          ''}"
        ];
      };
    };

    home.sessionVariables.TERMINAL = lib.mkIf config.host.terminal.alacritty.defaultTerminal "alacritty";
  };
}
