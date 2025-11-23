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
      mkPalette = neutrals: accents: {
        base00 = neutrals.base;
        base01 = neutrals.mantle;
        base02 = neutrals.surface0;
        base03 = neutrals.surface1;
        base04 = neutrals.surface2;
        base05 = neutrals.text;
        base06 = accents.rosewater;
        base07 = accents.lavender;
        base08 = accents.red;
        base09 = accents.peach;
        base0A = accents.yellow;
        base0B = accents.green;
        base0C = accents.teal;
        base0D = accents.blue;
        base0E = accents.mauve;
        base0F = accents.flamingo;
      };

      accents = {
        rosewater = {
          hex = "e06c75";
          rgb = {
            r = 224;
            g = 108;
            b = 117;
          };
          hsl = {
            h = 355;
            s = 65;
            l = 65;
          };
        };

        lavender = {
          hex = "c678dd";
          rgb = {
            r = 198;
            g = 120;
            b = 221;
          };
          hsl = {
            h = 286;
            s = 60;
            l = 67;
          };
        };

        red = {
          hex = "e06c75";
          rgb = {
            r = 224;
            g = 108;
            b = 117;
          };
          hsl = {
            h = 355;
            s = 65;
            l = 65;
          };
        };

        peach = {
          hex = "d19a66";
          rgb = {
            r = 209;
            g = 154;
            b = 102;
          };
          hsl = {
            h = 29;
            s = 54;
            l = 61;
          };
        };

        yellow = {
          hex = "e5c07b";
          rgb = {
            r = 229;
            g = 192;
            b = 123;
          };
          hsl = {
            h = 39;
            s = 67;
            l = 69;
          };
        };

        green = {
          hex = "98c379";
          rgb = {
            r = 152;
            g = 195;
            b = 121;
          };
          hsl = {
            h = 95;
            s = 38;
            l = 62;
          };
        };

        teal = {
          hex = "56b6c2";
          rgb = {
            r = 86;
            g = 182;
            b = 194;
          };
          hsl = {
            h = 187;
            s = 47;
            l = 55;
          };
        };

        blue = {
          hex = "61afef";
          rgb = {
            r = 97;
            g = 175;
            b = 239;
          };
          hsl = {
            h = 207;
            s = 82;
            l = 66;
          };
        };

        mauve = {
          hex = "c678dd";
          rgb = {
            r = 198;
            g = 120;
            b = 221;
          };
          hsl = {
            h = 286;
            s = 60;
            l = 67;
          };
        };

        flamingo = {
          hex = "e06c75";
          rgb = {
            r = 224;
            g = 108;
            b = 117;
          };
          hsl = {
            h = 355;
            s = 65;
            l = 65;
          };
        };
      };

      neutrals = {
        Dark = {
          base = {
            hex = "282c34";
            rgb = {
              r = 40;
              g = 44;
              b = 52;
            };
            hsl = {
              h = 220;
              s = 13;
              l = 18;
            };
          };

          mantle = {
            hex = "353b45";
            rgb = {
              r = 53;
              g = 59;
              b = 69;
            };
            hsl = {
              h = 218;
              s = 13;
              l = 24;
            };
          };

          surface0 = {
            hex = "3e4451";
            rgb = {
              r = 62;
              g = 68;
              b = 81;
            };
            hsl = {
              h = 221;
              s = 13;
              l = 28;
            };
          };

          surface1 = {
            hex = "545862";
            rgb = {
              r = 84;
              g = 88;
              b = 98;
            };
            hsl = {
              h = 223;
              s = 8;
              l = 36;
            };
          };

          surface2 = {
            hex = "565c64";
            rgb = {
              r = 86;
              g = 92;
              b = 100;
            };
            hsl = {
              h = 214;
              s = 8;
              l = 36;
            };
          };

          text = {
            hex = "abb2bf";
            rgb = {
              r = 171;
              g = 178;
              b = 191;
            };
            hsl = {
              h = 219;
              s = 14;
              l = 71;
            };
          };
        };

        Darker = {
          base = {
            hex = "1f2329";
            rgb = {
              r = 31;
              g = 35;
              b = 41;
            };
            hsl = {
              h = 216;
              s = 14;
              l = 14;
            };
          };

          mantle = {
            hex = "282c34";
            rgb = {
              r = 40;
              g = 44;
              b = 52;
            };
            hsl = {
              h = 220;
              s = 13;
              l = 18;
            };
          };

          surface0 = {
            hex = "30363f";
            rgb = {
              r = 48;
              g = 54;
              b = 63;
            };
            hsl = {
              h = 216;
              s = 14;
              l = 22;
            };
          };

          surface1 = {
            hex = "545862";
            rgb = {
              r = 84;
              g = 88;
              b = 98;
            };
            hsl = {
              h = 223;
              s = 8;
              l = 36;
            };
          };

          surface2 = {
            hex = "565c64";
            rgb = {
              r = 86;
              g = 92;
              b = 100;
            };
            hsl = {
              h = 214;
              s = 8;
              l = 36;
            };
          };

          text = {
            hex = "abb2bf";
            rgb = {
              r = 171;
              g = 178;
              b = 191;
            };
            hsl = {
              h = 219;
              s = 14;
              l = 71;
            };
          };
        };
      };

      onedarkColors = {
        Dark = mkPalette neutrals.Dark accents;
        Darker = mkPalette neutrals.Darker accents;
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
