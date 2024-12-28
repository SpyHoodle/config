{ config, lib, pkgs, ... }:

{
  options = {
    host.programs.steam.enable = lib.mkEnableOption "Enable steam, a game store and launcher";
  };

  config = lib.mkIf config.host.programs.steam.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;

      package = pkgs.steam.override
        {
          extraLibraries = pkgs: [ config.hardware.graphics.package ] ++ config.hardware.graphics.extraPackages;
        };
    };
    hardware.steam-hardware.enable = true;
  };
}
