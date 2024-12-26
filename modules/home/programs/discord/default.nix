{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    host.programs.discord.enable = lib.mkEnableOption {
      description = "Enable Discord, a chat application";
      default = false;
    };
  };

  config = lib.mkIf config.host.programs.discord.enable {
    home.packages = with pkgs; [ discord-canary ];
  };
}
