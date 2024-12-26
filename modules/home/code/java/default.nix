{
  lib,
  config,
  pkgs,
  ...
}:

{
  options = {
    host.home.code.java.enable = lib.mkEnableOption {
      description = "Enable Java programming language support";
      default = false;
    };
    host.home.code.java.package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.jdk17;
      description = "The JDK package to install";
    };
  };

  config = lib.mkIf config.host.home.code.java.enable {
    programs.java = {
      enable = true;
      package = config.host.home.code.java.package;
    };
  };
}
