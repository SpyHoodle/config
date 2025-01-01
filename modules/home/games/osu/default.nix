{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    host.games.osu.enable = lib.mkEnableOption "Enable osu!, the circle clicking rhythm game";
  };

  config = lib.mkIf config.host.games.osu.enable {
    home.packages = with pkgs; [ osu-lazer-bin ];
  };
}
