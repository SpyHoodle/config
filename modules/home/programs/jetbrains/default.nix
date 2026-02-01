{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    host.programs.jetbrains.enable = lib.mkEnableOption "Enable JetBrains IDEs";
  };

  config = lib.mkIf config.host.programs.jetbrains.enable {
    home.packages = with pkgs.jetbrains; [
      pycharm
      rust-rover
      clion
      webstorm
    ];
  };
}
