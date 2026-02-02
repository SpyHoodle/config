{
  config,
  lib,
  inputs,
  system,
  ...
}:

{
  options = {
    host.desktop.anyrun.enable = lib.mkEnableOption "Enable anyrun as the system runner";
  };

  config = lib.mkIf config.host.desktop.anyrun.enable {
    programs.anyrun = {
      enable = true;
      package = inputs.anyrun.packages.${system}.anyrun;

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
        @define-color accent #${config.host.theme.colors.pallete.${config.host.theme.colors.accent}.hex};
        @define-color bg-color #${config.host.theme.colors.pallete.base00.hex};
        @define-color fg-color #${config.host.theme.colors.pallete.base05.hex};
        @define-color desc-color #${config.host.theme.colors.pallete.base04.hex};

        window {
          background: transparent;
        }

        box.main {
          padding: 5px;
          margin: 10px;
          border-radius: ${builtins.toString config.host.theme.desktop.borders.rounding}px;
          border: 2px solid @accent;
          background-color: @bg-color;
          box-shadow: 0 0 10px black;
        }

        text {
          font-family: ${config.host.theme.font.sansSerif.name};
          font-size: ${builtins.toString (config.host.theme.font.sansSerif.size + 1)}px;
          padding: 3px;
          min-height: 30px;
          color: @fg-color;
        }

        .matches {
          background-color: rgba(0, 0, 0, 0);
          border-radius: ${builtins.toString config.host.theme.desktop.borders.rounding}px;
        }

        box.plugin:first-child {
          margin-top: 5px;
        }

        box.plugin.info {
          min-width: 200px;
        }

        list.plugin {
          background-color: rgba(0, 0, 0, 0);
        }

        label.match {
          font-family: ${config.host.theme.font.sansSerif.name};
          font-size: ${builtins.toString config.host.theme.font.sansSerif.size}px;
          margin: 0;
          padding: 0;
          min-height: 15px;
          color: @fg-color;
        }

        label.match.description {
          font-family: ${config.host.theme.font.sansSerif.name};
          font-size: ${builtins.toString (config.host.theme.font.sansSerif.size - 3)}px;
          margin: 0;
          padding: 0;
          min-height: 10px;
          color: @desc-color;
        }

        label.plugin.info {
          font-family: ${config.host.theme.font.sansSerif.name};
          font-size: ${builtins.toString config.host.theme.font.sansSerif.size}px;
          margin: 0;
          padding: 0;
          min-height: 10px;
          color: @fg-color;
        }

        .match {
          font-family: ${config.host.theme.font.sansSerif.name};
          font-size: ${builtins.toString config.host.theme.font.sansSerif.size}px;
          background: transparent;
          padding: 0;
          border: 2px solid transparent;
          border-radius: ${builtins.toString config.host.theme.desktop.borders.rounding}px;
        }

        .match:selected {
          border-radius: ${builtins.toString config.host.theme.desktop.borders.rounding}px;
          border: 2px solid @accent;
          background: transparent;
          animation: fade 0.3s linear;
        }

        @keyframes fade {
          0% {
            opacity: 0;
          }

          100% {
            opacity: 1;
          }
        }
      '';
    };
  };
}