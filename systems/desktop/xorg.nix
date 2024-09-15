{
  services.xserver = {
    # Enable X11 windowing system
    enable = true;

    # Set X11 keymap as GB
    xkb = {
      layout = "gb";
      options = "eurosign:e";
    };
  };
}
