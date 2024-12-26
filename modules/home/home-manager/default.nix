{ config, lib, ... }:

{
  options = {
    host.home-manager.enable = lib.mkEnableOption {
      description = "Enable home-manager configuration";
      default = true;
    };
    host.home-manager.username = lib.mkOption {
      type = lib.types.str;
      description = "Username of the user";
    };
    host.home-manager.homeDir = lib.mkOption {
      type = lib.types.str;
      description = "Home directory of the user";
    };
  };

  config = lib.mkIf config.host.home-manager.enable {
    programs.home-manager.enable = true;
    home = {
      username = config.host.home-manager.username;
      homeDirectory = lib.mkForce config.host.home-manager.homeDir;
      stateVersion = lib.mkForce "24.11";
    };
  };
}
