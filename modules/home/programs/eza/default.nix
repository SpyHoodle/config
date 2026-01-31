{ config, lib, ... }:

{
  options = {
    host.programs.eza.enable = lib.mkEnableOption "Enable Eza, a modern ls replacement";
  };

  config = lib.mkIf config.host.programs.eza.enable {
    programs.eza = {
      enable = true;
      icons = "auto";
      extraOptions = [
        "--group-directories-first"
        "--time-style=long-iso"
        "--git"
        "-h"
        "-g"
      ];
    };
  };
}
