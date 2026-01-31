{ config, lib, pkgs, ... }:

{
  options = {
    host.home-manager.enable = lib.mkOption {
      type = lib.types.bool;
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
      default = if pkgs.stdenv.isDarwin then "/Users/${config.host.home-manager.username}" else "/home/${config.host.home-manager.username}";
    };
    host.home-manager.stateVersion = lib.mkOption {
      type = lib.types.str;
      description = "Home Manager state version";
      default = "24.11";
    };
  };

  config = lib.mkIf config.host.home-manager.enable {
    programs.home-manager.enable = true;
    home = {
      username = config.host.home-manager.username;
      homeDirectory = lib.mkForce config.host.home-manager.homeDir;
      stateVersion = lib.mkForce config.host.home-manager.stateVersion;
    };
  };
}