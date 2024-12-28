{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    host.code.rust.enable = lib.mkEnableOption {
      description = "Enable Rust programming language support";
      default = true;
    };
  };

  config = lib.mkIf config.host.code.rust.enable {
    home.packages = with pkgs; [ rustup ];

    home = {
      sessionVariables = {
        CARGO_HOME = "${config.xdg.dataHome}/cargo";
        RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
      };
      sessionPath = [ "${config.home.sessionVariables.CARGO_HOME}/bin" ];
    };
  };
}
