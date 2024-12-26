{ config, lib, ... }:

{
  options = {
    host.input.keyboard.layout = lib.mkOption {
      type = lib.types.str;
      default = "uk";
    };
  };

  config = {
    console.keyMap = config.host.input.keyboard.layout;
  };
}
