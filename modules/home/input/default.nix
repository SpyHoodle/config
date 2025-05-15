{ lib, config, ... }:

{
  options = {
    host.input.mouse.scrolling.natural = lib.mkEnableOption "Enable natural scrolling";
    host.input.trackpad.scrolling.natural = lib.mkOption {
      type = lib.types.bool;
      description = "Enable natural scrolling";
      default = config.host.input.mouse.scrolling.natural;
    };
    host.input.trackpad.scrolling.factor = lib.mkOption {
      type = lib.types.float;
      description = "Scrolling factor";
      default = 1.0;
    };
    host.input.trackpad.tapToClick = lib.mkOption {
      type = lib.types.bool;
      description = "Enable tap to click";
      default = true;
    };
    host.input.mouse.sensitivity = lib.mkOption {
      type = lib.types.float;
      description = "Mouse sensitivity";
      default = 0.6;
    };
    host.input.keyboard = {
      variant = lib.mkOption {
        type = lib.types.str;
        description = "Keyboard variant";
        default = "gb";
      };
      layout = lib.mkOption {
        type = lib.types.str;
        description = "Keyboard layout";
        default = "";
      };
      appleMagic.enable = lib.mkEnableOption "Enable Apple Magic Keyboard support";
    };
  };
}
