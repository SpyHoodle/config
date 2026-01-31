{
  config,
  lib,
  ...
}:

{
  options = {
    host.programs.nh.enable = lib.mkEnableOption "Enable the NH (Nix Helper) CLI tool";
    host.programs.nh.garbageCollection.enable = lib.mkEnableOption "Enable NH's garbage collection";
  };

  config = lib.mkIf config.host.programs.nh.enable {
    programs.nh = {
      enable = true;
      clean.enable = config.host.programs.nh.garbageCollection.enable;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "${config.home.homeDirectory}/Code/config";
    };
  };
}
