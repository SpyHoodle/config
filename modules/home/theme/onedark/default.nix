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
      onedarkPalette = {
        base00 = {
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
        base01 = {
          hex = "31353f";
          rgb = {
            r = 49;
            g = 53;
            b = 63;
          };
          hsl = {
            h = 223;
            s = 12;
            l = 22;
          };
        };
        base02 = {
          hex = "31392b";
          rgb = {
            r = 49;
            g = 57;
            b = 43;
          };
          hsl = {
            h = 94;
            s = 14;
            l = 20;
          };
        };
        base03 = {
          hex = "1c3448";
          rgb = {
            r = 28;
            g = 52;
            b = 72;
          };
          hsl = {
            h = 207;
            s = 44;
            l = 20;
          };
        };
        base04 = {
          hex = "2c5372";
          rgb = {
            r = 44;
            g = 83;
            b = 114;
          };
          hsl = {
            h = 207;
            s = 44;
            l = 31;
          };
        };
        base05 = {
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
        base06 = {
          hex = "848b98";
          rgb = {
            r = 132;
            g = 139;
            b = 152;
          };
          hsl = {
            h = 219;
            s = 9;
            l = 56;
          };
        };
        base07 = {
          hex = "5c6370";
          rgb = {
            r = 92;
            g = 99;
            b = 112;
          };
          hsl = {
            h = 219;
            s = 10;
            l = 40;
          };
        };
        base08 = {
          hex = "e86671";
          rgb = {
            r = 232;
            g = 102;
            b = 113;
          };
          hsl = {
            h = 355;
            s = 74;
            l = 65;
          };
        };
        base09 = {
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
        base0A = {
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
        base0B = {
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
        base0C = {
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
        base0D = {
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
        base0E = {
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
        base0F = {
          hex = "993939";
          rgb = {
            r = 153;
            g = 57;
            b = 57;
          };
          hsl = {
            h = 0;
            s = 46;
            l = 41;
          };
        };
      };

      onedarkColors = {
        Dark = onedarkPalette;
        Darker = onedarkPalette;
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
