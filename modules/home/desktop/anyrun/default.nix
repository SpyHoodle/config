{
  config,
  lib,
  inputs,
  system,
  ...
}:

{
  options = {
    host.desktop.anyrun.enable = lib.mkEnableOption {
      description = "Enable anyrun as the system runner";
      default = true;
    };
  };

  config = lib.mkIf config.host.desktop.anyrun.enable {
    programs.anyrun = {
      enable = true;

      config = {
        plugins = with inputs.anyrun.packages.${system}; [
          applications
          rink
          shell
          translate
          kidex
          symbols
          dictionary
          randr
        ];

        x = {
          fraction = 0.5;
        };
        y = {
          fraction = 0.2;
        };
        width = {
          fraction = 0.3;
        };
        closeOnClick = true;
      };

      extraCss = ''
        #window {
          background-color: transparent;
        }
        #main * {
          background-color: #${config.host.theme.colors.pallete.base00.hex};
          color: #${config.host.theme.colors.pallete.base05.hex};
          caret-color: alpha(#${
            config.host.theme.colors.pallete.${config.host.theme.colors.accent}.hex
          },0.6);
          font-family: ${config.host.theme.font.sansSerif.name};
          font-size: ${builtins.toString config.host.theme.font.sansSerif.size}px;
        }
        #main {
          border-width: 3px;
          border-style: solid;
          border-color: #${config.host.theme.colors.pallete.${config.host.theme.colors.accent}.hex};
          border-radius: 8px;
        }
        #main #main {
          border-style: none;
          border-bottom-left-radius: 5px;
          border-bottom-right-radius: 5px;
        }
        #match-title, #match-desc {
          font-family: ${config.host.theme.font.sansSerif.name};
        }
        #entry {
          min-height: 36px;
          padding: 10px;
          font-size: 24px;
          box-shadow: none;
          border-style: none;
        }
        #entry:focus {
          box-shadow: none;
        }
        #entry selection {
          background-color: alpha(#${config.host.theme.colors.pallete.base0A.hex},0.3);
          color: transparent;
        }
      '';
    };
  };
}
