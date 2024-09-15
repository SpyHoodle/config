{
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
        normal.family = "IosevkaNerdFont";
        bold.family = "IosevkaNerdFont";
        italic.family = "IosevkaNerdFont";
        size = 12;
      };
      scrolling.history = 10000;

      colors.draw_bold_text_with_bright_colors = true;
      window.opacity = 0.9;

      import = [
        ./alacritty/onedark.toml
      ];
    };
  };
}
