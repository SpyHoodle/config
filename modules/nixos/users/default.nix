{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    host.user.enable = lib.mkEnableOption "Enable user configuration";
    host.user.name = lib.mkOption {
      type = lib.types.str;
      default = "nixos";
      description = "The name of the main user";
    };
    host.user.fullName = lib.mkOption {
      type = lib.types.str;
      default = "NixOS User";
      description = "The full name of the main user";
    };
    host.user.hashedPassword = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "The hashed password of the main user. Generate with `mkpasswd -m SHA-512`";
    };
    host.user.initialPassword = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Initial password for the user (will prompt to change on first login)";
    };
    host.user.extraGroups = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Extra groups for the main user";
    };
    host.user.sshKeys = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "SSH keys";
    };
    host.user.shell = lib.mkOption {
      type = lib.types.package;
      default = pkgs.zsh;
      description = "The shell of the main user";
    };
  };

  config = lib.mkIf config.host.user.enable {
    users.users = {
      ${config.host.user.name} = {
        isNormalUser = true;
        createHome = true;
        description = config.host.user.fullName;
        extraGroups = config.host.user.extraGroups;
        hashedPassword = config.host.user.hashedPassword;
        initialPassword = lib.mkIf (config.host.user.hashedPassword == null) config.host.user.initialPassword;
        openssh.authorizedKeys.keys = config.host.user.sshKeys;
        shell = config.host.user.shell;
      };
    };
  };
}
