{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.host.theme.onedark = {
    enable = lib.mkEnableOption {
      description = "Whether to use the OneDark theme";
      default = false;
    };

    style = lib.mkOption {
      type = lib.types.enum [
        "Dark"
        "Darker"
      ];
      default = "Darker";
      description = "OneDark variant to use";
    };
  };

  config =
    let
      onedarkColors = {
        Dark = {
          base00 = {
            hex = "eff1f5";
            rgb = {
              r = 239;
              g = 241;
              b = 245;
            };
            hsl = {
              h = 220;
              s = 23;
              l = 95;
            };
          };
          base01 = {
            hex = "e6e9ef";
            rgb = {
              r = 230;
              g = 233;
              b = 239;
            };
            hsl = {
              h = 220;
              s = 22;
              l = 92;
            };
          };
          base02 = {
            hex = "ccd0da";
            rgb = {
              r = 204;
              g = 208;
              b = 218;
            };
            hsl = {
              h = 223;
              s = 16;
              l = 83;
            };
          };
          base03 = {
            hex = "bcc0cc";
            rgb = {
              r = 188;
              g = 192;
              b = 204;
            };
            hsl = {
              h = 225;
              s = 14;
              l = 77;
            };
          };
          base04 = {
            hex = "acb0be";
            rgb = {
              r = 172;
              g = 176;
              b = 190;
            };
            hsl = {
              h = 227;
              s = 12;
              l = 71;
            };
          };
          base05 = {
            hex = "4c4f69";
            rgb = {
              r = 76;
              g = 79;
              b = 105;
            };
            hsl = {
              h = 234;
              s = 16;
              l = 35;
            };
          };
          base06 = {
            hex = "dc8a78";
            rgb = {
              r = 220;
              g = 138;
              b = 120;
            };
            hsl = {
              h = 11;
              s = 59;
              l = 67;
            };
          };
          base07 = {
            hex = "7287fd";
            rgb = {
              r = 114;
              g = 135;
              b = 253;
            };
            hsl = {
              h = 231;
              s = 97;
              l = 72;
            };
          };
          base08 = {
            hex = "d20f39";
            rgb = {
              r = 210;
              g = 15;
              b = 57;
            };
            hsl = {
              h = 347;
              s = 87;
              l = 44;
            };
          };
          base09 = {
            hex = "fe640b";
            rgb = {
              r = 254;
              g = 100;
              b = 11;
            };
            hsl = {
              h = 22;
              s = 99;
              l = 52;
            };
          };
          base0A = {
            hex = "df8e1d";
            rgb = {
              r = 223;
              g = 142;
              b = 29;
            };
            hsl = {
              h = 35;
              s = 77;
              l = 49;
            };
          };
          base0B = {
            hex = "40a02b";
            rgb = {
              r = 64;
              g = 160;
              b = 43;
            };
            hsl = {
              h = 109;
              s = 58;
              l = 40;
            };
          };
          base0C = {
            hex = "179299";
            rgb = {
              r = 23;
              g = 146;
              b = 153;
            };
            hsl = {
              h = 183;
              s = 74;
              l = 35;
            };
          };
          base0D = {
            hex = "1e66f5";
            rgb = {
              r = 30;
              g = 102;
              b = 245;
            };
            hsl = {
              h = 220;
              s = 91;
              l = 54;
            };
          };
          base0E = {
            hex = "8839ef";
            rgb = {
              r = 136;
              g = 57;
              b = 239;
            };
            hsl = {
              h = 266;
              s = 85;
              l = 58;
            };
          };
          base0F = {
            hex = "dd7878";
            rgb = {
              r = 221;
              g = 120;
              b = 120;
            };
            hsl = {
              h = 0;
              s = 60;
              l = 67;
            };
          };
        };

        Darker = {
          base00 = {
            hex = "eff1f5";
            rgb = {
              r = 239;
              g = 241;
              b = 245;
            };
            hsl = {
              h = 220;
              s = 23;
              l = 95;
            };
          };
          base01 = {
            hex = "e6e9ef";
            rgb = {
              r = 230;
              g = 233;
              b = 239;
            };
            hsl = {
              h = 220;
              s = 22;
              l = 92;
            };
          };
          base02 = {
            hex = "ccd0da";
            rgb = {
              r = 204;
              g = 208;
              b = 218;
            };
            hsl = {
              h = 223;
              s = 16;
              l = 83;
            };
          };
          base03 = {
            hex = "bcc0cc";
            rgb = {
              r = 188;
              g = 192;
              b = 204;
            };
            hsl = {
              h = 225;
              s = 14;
              l = 77;
            };
          };
          base04 = {
            hex = "acb0be";
            rgb = {
              r = 172;
              g = 176;
              b = 190;
            };
            hsl = {
              h = 227;
              s = 12;
              l = 71;
            };
          };
          base05 = {
            hex = "4c4f69";
            rgb = {
              r = 76;
              g = 79;
              b = 105;
            };
            hsl = {
              h = 234;
              s = 16;
              l = 35;
            };
          };
          base06 = {
            hex = "dc8a78";
            rgb = {
              r = 220;
              g = 138;
              b = 120;
            };
            hsl = {
              h = 11;
              s = 59;
              l = 67;
            };
          };
          base07 = {
            hex = "7287fd";
            rgb = {
              r = 114;
              g = 135;
              b = 253;
            };
            hsl = {
              h = 231;
              s = 97;
              l = 72;
            };
          };
          base08 = {
            hex = "d20f39";
            rgb = {
              r = 210;
              g = 15;
              b = 57;
            };
            hsl = {
              h = 347;
              s = 87;
              l = 44;
            };
          };
          base09 = {
            hex = "fe640b";
            rgb = {
              r = 254;
              g = 100;
              b = 11;
            };
            hsl = {
              h = 22;
              s = 99;
              l = 52;
            };
          };
          base0A = {
            hex = "df8e1d";
            rgb = {
              r = 223;
              g = 142;
              b = 29;
            };
            hsl = {
              h = 35;
              s = 77;
              l = 49;
            };
          };
          base0B = {
            hex = "40a02b";
            rgb = {
              r = 64;
              g = 160;
              b = 43;
            };
            hsl = {
              h = 109;
              s = 58;
              l = 40;
            };
          };
          base0C = {
            hex = "179299";
            rgb = {
              r = 23;
              g = 146;
              b = 153;
            };
            hsl = {
              h = 183;
              s = 74;
              l = 35;
            };
          };
          base0D = {
            hex = "1e66f5";
            rgb = {
              r = 30;
              g = 102;
              b = 245;
            };
            hsl = {
              h = 220;
              s = 91;
              l = 54;
            };
          };
          base0E = {
            hex = "8839ef";
            rgb = {
              r = 136;
              g = 57;
              b = 239;
            };
            hsl = {
              h = 266;
              s = 85;
              l = 58;
            };
          };
          base0F = {
            hex = "dd7878";
            rgb = {
              r = 221;
              g = 120;
              b = 120;
            };
            hsl = {
              h = 0;
              s = 60;
              l = 67;
            };
          };
        };
      };
    in
    lib.mkIf config.host.theme.onedark.enable {
      host.theme = {
        colors.pallete = onedarkColors.${config.host.theme.onedark.style};
        style = "Dark";

        cursor = {
          package = pkgs.bibata-cursors;
          name = "Bibata-Modern-Classic";
          size = 24;
        };
      };

      gtk = {
        enable = true;
        cursorTheme = lib.mkForce {
          package = config.host.theme.cursor.package;
          name = config.host.theme.cursor.name;
          size = config.host.theme.cursor.size;
        };
      };
    };
}
