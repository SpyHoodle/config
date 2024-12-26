{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    host.games.minecraft.enable = lib.mkEnableOption "Enable Minecraft, a popular sandbox game";
    host.games.minecraft.launcher.package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.prismlauncher;
      description = "The package of the Minecraft launcher";
    };
  };

  config = lib.mkIf config.host.games.minecraft.enable {
    home.packages = with pkgs; [ config.host.games.minecraft.launcher.package ];
  };
}
