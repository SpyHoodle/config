{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    host.code.python.enable = lib.mkEnableOption "Enable Python programming language support";
    host.code.python.package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.python312;
      description = "The Python package to install";
    };
  };

  config = lib.mkIf config.host.code.python.enable {
    home.packages = [ config.host.code.python.package ];
  };
}
