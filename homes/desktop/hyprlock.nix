{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        grace = 300;
        hide_cursor = true;
        no_fade_in = false;
      };

      background = [
        {
          path = "/home/maddie/Code/config/homes/desktop/hyprpaper/nasa-img-09-13.png";
          blur_passes = 3;
          blur_size = 8;
        }
      ];

      input-field = [
        {
          placeholder_text = "";
          size = "300, 70";
          rounding = -1;
          position = "0, 0";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          font_color = "#ffffff";
          fail_color = "#e06c75";
          inner_color = "#1e2127";
          outer_color = "#5c6370";
          outline_thickness = 3;
          shadow_passes = 0;
        }
      ];
    };
  };
}
