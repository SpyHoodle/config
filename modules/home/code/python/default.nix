{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    host.code.python.enable = lib.mkEnableOption {
      description = "Enable Python programming language support";
      default = false;
    };
    host.code.python.package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.python312;
      description = "The Python package to install";
    };
  };

  config = lib.mkIf config.host.code.python.enable {
    home.packages = with pkgs; [ config.host.code.python.package ];
  };
}
