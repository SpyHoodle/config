{
  lib,
  config,
  pkgs,
  ...
}:

{
  options = {
    host.code.java.enable = lib.mkEnableOption "Enable Java programming language support";
    host.code.java.package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.jdk17;
      description = "The JDK package to install";
    };
  };

  config = lib.mkIf config.host.code.java.enable {
    programs.java = {
      enable = true;
      package = config.host.code.java.package;
    };
  };
}
