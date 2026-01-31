{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    host.programs.gemini.enable = lib.mkEnableOption "Enable gemini-cli-bin";
  };

  config = lib.mkIf config.host.programs.gemini.enable {
    home.packages = with pkgs; [ gemini-cli-bin ];
  };
}
