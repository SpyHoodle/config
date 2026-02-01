{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    host.programs.discord.enable = lib.mkEnableOption "Enable Discord, a chat application";
  };

  config = lib.mkIf config.host.programs.discord.enable {
    home.packages = with pkgs; [ discord-canary ];
  };
}
