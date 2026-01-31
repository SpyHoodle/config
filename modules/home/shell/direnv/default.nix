{ config, lib, ... }:

{
  options = {
    host.shell.direnv.enable = lib.mkEnableOption "Enable direnv for per-project environment management";
  };

  config = lib.mkIf config.host.shell.direnv.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
