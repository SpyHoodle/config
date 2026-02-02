{
  lib,
  ...
}:

{
  imports = [
    ./keybinds.nix
    ./settings.nix
  ];

  options = {
    host.desktop.hyprland = {
      enable = lib.mkEnableOption "Use hyprland as your window manager";
      monitors = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        description = "List of default monitors to set";
        default = [ ];
      };
      startupApps = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        description = "List of commands to run on hyprland start";
        default = [ ];
      };
      keybinds = {
        volumeStep = lib.mkOption {
          type = lib.types.int;
          description = "Amount to increase volume by when media keys are pressed in %";
          example = "5";
          default = 5;
        };
        extraBinds =
          let
            binds = lib.types.submodule {
              options = {
                meta = lib.mkOption {
                  type = lib.types.nullOr lib.types.str;
                  description = "Additional modifier keys space seperated";
                  default = null;
                };
                key = lib.mkOption {
                  type = lib.types.str;
                  description = "Final key";
                };
                function = lib.mkOption {
                  type = lib.types.str;
                  description = "Hyprland bind function";
                };
              };
            };
          in
          lib.mkOption {
            type = lib.types.listOf binds;
            description = "Extra keybinds to add";
            default = [ ];
          };
      };
    };
  };
}