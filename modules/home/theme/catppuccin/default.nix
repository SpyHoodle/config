{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.host.theme.catppuccin = {
    enable = lib.mkEnableOption "Use Catppuccin themes";
    style = lib.mkOption {
      type = lib.types.enum [
        "Latte"
        "Frappe"
        "Macchiato"
        "Mocha"
      ];
      default = "Mocha";
      description = "Catppuccin style to use";
    };
  };

  config =
    let
      catppuccinColors = {
        Latte = {
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
        };
        Frappe = {
          base06 = {
            hex = "f2d5cf";
            rgb = {
              r = 242;
              g = 213;
              b = 207;
            };
            hsl = {
              h = 10;
              s = 57;
              l = 88;
            };
          };
          base0F = {
            hex = "eebebe";
            rgb = {
              r = 238;
              g = 190;
              b = 190;
            };
            hsl = {
              h = 0;
              s = 59;
              l = 84;
            };
          };
          Pink = {
            hex = "f4b8e4";
            rgb = {
              r = 244;
              g = 184;
              b = 228;
            };
            hsl = {
              h = 316;
              s = 73;
              l = 84;
            };
          };
          base0E = {
            hex = "ca9ee6";
            rgb = {
              r = 202;
              g = 158;
              b = 230;
            };
            hsl = {
              h = 277;
              s = 59;
              l = 76;
            };
          };
          base08 = {
            hex = "e78284";
            rgb = {
              r = 231;
              g = 130;
              b = 132;
            };
            hsl = {
              h = 359;
              s = 68;
              l = 71;
            };
          };
          base09 = {
            hex = "ef9f76";
            rgb = {
              r = 239;
              g = 159;
              b = 118;
            };
            hsl = {
              h = 20;
              s = 79;
              l = 70;
            };
          };
          base0A = {
            hex = "e5c890";
            rgb = {
              r = 229;
              g = 200;
              b = 144;
            };
            hsl = {
              h = 40;
              s = 62;
              l = 73;
            };
          };
          base0B = {
            hex = "a6d189";
            rgb = {
              r = 166;
              g = 209;
              b = 137;
            };
            hsl = {
              h = 96;
              s = 44;
              l = 68;
            };
          };
          base0C = {
            hex = "81c8be";
            rgb = {
              r = 129;
              g = 200;
              b = 190;
            };
            hsl = {
              h = 172;
              s = 39;
              l = 65;
            };
          };
          base0D = {
            hex = "8caaee";
            rgb = {
              r = 140;
              g = 170;
              b = 238;
            };
            hsl = {
              h = 222;
              s = 74;
              l = 74;
            };
          };
          base07 = {
            hex = "babbf1";
            rgb = {
              r = 186;
              g = 187;
              b = 241;
            };
            hsl = {
              h = 239;
              s = 66;
              l = 84;
            };
          };
          base05 = {
            hex = "c6d0f5";
            rgb = {
              r = 198;
              g = 208;
              b = 245;
            };
            hsl = {
              h = 227;
              s = 70;
              l = 87;
            };
          };
          base04 = {
            hex = "626880";
            rgb = {
              r = 98;
              g = 104;
              b = 128;
            };
            hsl = {
              h = 228;
              s = 13;
              l = 44;
            };
          };
          base03 = {
            hex = "51576d";
            rgb = {
              r = 81;
              g = 87;
              b = 109;
            };
            hsl = {
              h = 227;
              s = 15;
              l = 37;
            };
          };
          base02 = {
            hex = "414559";
            rgb = {
              r = 65;
              g = 69;
              b = 89;
            };
            hsl = {
              h = 230;
              s = 16;
              l = 30;
            };
          };
          base00 = {
            hex = "303446";
            rgb = {
              r = 48;
              g = 52;
              b = 70;
            };
            hsl = {
              h = 229;
              s = 19;
              l = 23;
            };
          };
          base01 = {
            hex = "292c3c";
            rgb = {
              r = 41;
              g = 44;
              b = 60;
            };
            hsl = {
              h = 231;
              s = 19;
              l = 20;
            };
          };
        };
        Macchiato = {
          base06 = {
            hex = "f4dbd6";
            rgb = {
              r = 244;
              g = 219;
              b = 214;
            };
            hsl = {
              h = 10;
              s = 58;
              l = 90;
            };
          };
          base0F = {
            hex = "f0c6c6";
            rgb = {
              r = 240;
              g = 198;
              b = 198;
            };
            hsl = {
              h = 0;
              s = 58;
              l = 86;
            };
          };
          base0E = {
            hex = "c6a0f6";
            rgb = {
              r = 198;
              g = 160;
              b = 246;
            };
            hsl = {
              h = 267;
              s = 83;
              l = 80;
            };
          };
          base08 = {
            hex = "ed8796";
            rgb = {
              r = 237;
              g = 135;
              b = 150;
            };
            hsl = {
              h = 351;
              s = 74;
              l = 73;
            };
          };
          base09 = {
            hex = "f5a97f";
            rgb = {
              r = 245;
              g = 169;
              b = 127;
            };
            hsl = {
              h = 21;
              s = 86;
              l = 73;
            };
          };
          base0A = {
            hex = "eed49f";
            rgb = {
              r = 238;
              g = 212;
              b = 159;
            };
            hsl = {
              h = 40;
              s = 70;
              l = 78;
            };
          };
          base0B = {
            hex = "a6da95";
            rgb = {
              r = 166;
              g = 218;
              b = 149;
            };
            hsl = {
              h = 105;
              s = 48;
              l = 72;
            };
          };
          base0C = {
            hex = "8bd5ca";
            rgb = {
              r = 139;
              g = 213;
              b = 202;
            };
            hsl = {
              h = 171;
              s = 47;
              l = 69;
            };
          };
          base0D = {
            hex = "8aadf4";
            rgb = {
              r = 138;
              g = 173;
              b = 244;
            };
            hsl = {
              h = 220;
              s = 83;
              l = 75;
            };
          };
          base07 = {
            hex = "b7bdf8";
            rgb = {
              r = 183;
              g = 189;
              b = 248;
            };
            hsl = {
              h = 234;
              s = 82;
              l = 85;
            };
          };
          base05 = {
            hex = "cad3f5";
            rgb = {
              r = 202;
              g = 211;
              b = 245;
            };
            hsl = {
              h = 227;
              s = 68;
              l = 88;
            };
          };
          base04 = {
            hex = "5b6078";
            rgb = {
              r = 91;
              g = 96;
              b = 120;
            };
            hsl = {
              h = 230;
              s = 14;
              l = 41;
            };
          };
          base03 = {
            hex = "494d64";
            rgb = {
              r = 73;
              g = 77;
              b = 100;
            };
            hsl = {
              h = 231;
              s = 16;
              l = 34;
            };
          };
          base02 = {
            hex = "363a4f";
            rgb = {
              r = 54;
              g = 58;
              b = 79;
            };
            hsl = {
              h = 230;
              s = 19;
              l = 26;
            };
          };
          base00 = {
            hex = "24273a";
            rgb = {
              r = 36;
              g = 39;
              b = 58;
            };
            hsl = {
              h = 232;
              s = 23;
              l = 18;
            };
          };
          base01 = {
            hex = "1e2030";
            rgb = {
              r = 30;
              g = 32;
              b = 48;
            };
            hsl = {
              h = 233;
              s = 23;
              l = 15;
            };
          };
        };
        Mocha = {
          base06 = {
            hex = "f5e0dc";
            rgb = {
              r = 245;
              g = 224;
              b = 220;
            };
            hsl = {
              h = 10;
              s = 56;
              l = 91;
            };
          };
          base0F = {
            hex = "f2cdcd";
            rgb = {
              r = 242;
              g = 205;
              b = 205;
            };
            hsl = {
              h = 0;
              s = 59;
              l = 88;
            };
          };
          base0E = {
            hex = "cba6f7";
            rgb = {
              r = 203;
              g = 166;
              b = 247;
            };
            hsl = {
              h = 267;
              s = 84;
              l = 81;
            };
          };
          base08 = {
            hex = "f38ba8";
            rgb = {
              r = 243;
              g = 139;
              b = 168;
            };
            hsl = {
              h = 343;
              s = 81;
              l = 75;
            };
          };
          base09 = {
            hex = "fab387";
            rgb = {
              r = 250;
              g = 179;
              b = 135;
            };
            hsl = {
              h = 23;
              s = 92;
              l = 75;
            };
          };
          base0A = {
            hex = "f9e2af";
            rgb = {
              r = 249;
              g = 226;
              b = 175;
            };
            hsl = {
              h = 41;
              s = 86;
              l = 83;
            };
          };
          base0B = {
            hex = "a6e3a1";
            rgb = {
              r = 166;
              g = 227;
              b = 161;
            };
            hsl = {
              h = 115;
              s = 54;
              l = 76;
            };
          };
          base0C = {
            hex = "94e2d5";
            rgb = {
              r = 148;
              g = 226;
              b = 213;
            };
            hsl = {
              h = 170;
              s = 57;
              l = 73;
            };
          };
          base0D = {
            hex = "89b4fa";
            rgb = {
              r = 137;
              g = 180;
              b = 250;
            };
            hsl = {
              h = 217;
              s = 92;
              l = 76;
            };
          };
          base07 = {
            hex = "b4befe";
            rgb = {
              r = 180;
              g = 190;
              b = 254;
            };
            hsl = {
              h = 232;
              s = 97;
              l = 85;
            };
          };
          base05 = {
            hex = "cdd6f4";
            rgb = {
              r = 205;
              g = 214;
              b = 244;
            };
            hsl = {
              h = 226;
              s = 64;
              l = 88;
            };
          };
          base04 = {
            hex = "585b70";
            rgb = {
              r = 88;
              g = 91;
              b = 112;
            };
            hsl = {
              h = 233;
              s = 12;
              l = 39;
            };
          };
          base03 = {
            hex = "45475a";
            rgb = {
              r = 69;
              g = 71;
              b = 90;
            };
            hsl = {
              h = 234;
              s = 13;
              l = 31;
            };
          };
          base02 = {
            hex = "313244";
            rgb = {
              r = 49;
              g = 50;
              b = 68;
            };
            hsl = {
              h = 237;
              s = 16;
              l = 23;
            };
          };
          base00 = {
            hex = "1e1e2e";
            rgb = {
              r = 30;
              g = 30;
              b = 46;
            };
            hsl = {
              h = 240;
              s = 21;
              l = 15;
            };
          };
          base01 = {
            hex = "181825";
            rgb = {
              r = 24;
              g = 24;
              b = 37;
            };
            hsl = {
              h = 240;
              s = 21;
              l = 12;
            };
          };
        };
      };
    in
    lib.mkIf config.host.theme.catppuccin.enable {
      host.theme = {
        colors.pallete = catppuccinColors.${config.host.theme.catppuccin.style};
        style = if config.host.theme.catppuccin.style == "Latte" then "Light" else "Dark";

        cursor = {
          package =
            pkgs.catppuccin-cursors."${lib.strings.toLower config.host.theme.catppuccin.style}${config.host.theme.style}";
          name = "catppuccin-${lib.strings.toLower config.host.theme.catppuccin.style}-${lib.strings.toLower config.host.theme.style}-cursors";
          size = 24;
        };
      };

      gtk =
        let
          flavor = lib.strings.toLower config.host.theme.catppuccin.style;
          isDark = config.host.theme.style == "Dark";
        in
        {
          enable = true;

          cursorTheme = lib.mkForce {
            package =
              pkgs.catppuccin-cursors."${flavor}${config.host.theme.style}";
            name = "catppuccin-${flavor}-${lib.strings.toLower config.host.theme.style}-cursors";
            size = config.host.theme.cursor.size;
          };

          theme = lib.mkForce {
            package = pkgs.catppuccin-gtk.override {
              accents = [ "blue" ];
              variant = flavor;
            };
            name = "catppuccin-${flavor}-blue-standard";
          };

          iconTheme = lib.mkForce {
            package = pkgs.catppuccin-papirus-folders.override {
              flavor = flavor;
              accent = "blue";
            };
            name = "Papirus-${if isDark then "Dark" else "Light"}";
          };
        };

      # QT theming with Catppuccin Kvantum
      qt = lib.mkForce {
        enable = true;
        platformTheme.name = "kvantum";
        style = {
          name = "kvantum";
          package = pkgs.libsForQt5.qtstyleplugin-kvantum;
        };
      };

      home.packages = [
        pkgs.libsForQt5.qtstyleplugin-kvantum
        pkgs.kdePackages.qtstyleplugin-kvantum
        (pkgs.catppuccin-kvantum.override {
          accent = "blue";
          variant = lib.strings.toLower config.host.theme.catppuccin.style;
        })
      ];

      # Kvantum theme configuration for Catppuccin
      xdg.configFile."Kvantum/kvantum.kvconfig".text =
        let
          flavor = lib.strings.toLower config.host.theme.catppuccin.style;
          # Capitalize first letter for theme name
          flavorCapitalized = lib.strings.concatStrings [
            (lib.strings.toUpper (lib.strings.substring 0 1 flavor))
            (lib.strings.substring 1 (-1) flavor)
          ];
        in
        ''
          [General]
          theme=catppuccin-${flavor}-blue
        '';
    };
}
