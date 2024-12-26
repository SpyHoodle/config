{ config, lib, ... }:

{
  options = {
    host.programs.nix-ld.enable = lib.mkEnableOption "Enable nix-ld, to execute unpatched dynamic binaries";
  };

  config = lib.mkIf config.host.programs.nix-ld.enable {
    programs.nix-ld.enable = true;
  };
}
