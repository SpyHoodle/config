{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    host.games.tetrio.enable = lib.mkEnableOption "Enable tetrio desktop";
  };

  config = lib.mkIf config.host.games.tetrio.enable {
    home.packages = with pkgs; [ tetrio-desktop ];
  };
}
