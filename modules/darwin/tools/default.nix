{
  config,
  pkgs,
  lib,
  ...
}:

{
  options = {
    host.programs.tools.enable = lib.mkEnableOption "Enable reccommended tools";
  };
  config = lib.mkIf config.host.programs.tools.enable {
    environment.systemPackages = with pkgs; [
      killall
      dosfstools
      zip
      unrar
      unzip
      p7zip
      ripgrep
      wget
      fzf
      bat
      git
      gcc
    ];
  };
}
