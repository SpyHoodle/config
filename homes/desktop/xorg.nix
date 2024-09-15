{ config, ... }:

{
  # Attempt to set keyboard layout
  home.keyboard = {
    layout = "gb";
    options = [
      "caps:escape"
    ];
  };

  # Force use of XDG Dir Spec
  home.sessionVariables = {
    XCOMPOSECACHE = "${config.xdg.cacheHome}/x11/xcompose";
  };

  # Set global font
  xresources.properties = {
    "*.font" = "Iosevka:pixelsize=12:antialias=true:autohint=true";
  };
}
