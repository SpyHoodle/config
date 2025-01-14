{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    host.programs.spotify.enable = lib.mkEnableOption "Enable Spotify, the desktop app for the Spotify music service";
  };

  config = lib.mkIf config.host.programs.spotify.enable {
    home.packages = with pkgs; [ spotify ];
  };
}
