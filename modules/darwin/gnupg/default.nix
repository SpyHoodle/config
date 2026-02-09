{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    host.programs.gnupg.enable = lib.mkEnableOption "Enable GnuPG from nixpkgs";
  };

  config = lib.mkIf config.host.programs.gnupg.enable {
    environment.systemPackages = with pkgs; [ gnupg ];
  };
}
