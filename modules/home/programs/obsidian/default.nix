{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    host.programs.obsidian.enable = lib.mkEnableOption "Enable obsidian, a note-taking application";
  };

  config = lib.mkIf config.host.programs.obsidian.enable {
    home.packages = with pkgs; [ obsidian ];
  };
}
