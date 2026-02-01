{
  pkgs,
  config,
  lib,
  inputs,
  system,
  ...
}:

{
  options.host.theme = {
    enable = lib.mkEnableOption "Enable centralised managed theme";
    font = {
      mono = lib.mkOption {
        type = inputs.home-manager.lib.hm.types.fontType;
        description = "Mono width font to use as system default";
        default = {
          name = "Iosevka Nerd Font";
          package = pkgs.nerd-fonts.iosevka;
          size = 12;
        };
      };
      serif = lib.mkOption {
        type = inputs.home-manager.lib.hm.types.fontType;
        description = "Serif variable width font to use as system default";
        default = {
          name = "SF Pro Text";
          package = inputs.apple-fonts.packages.${system}.sf-pro;
          size = 14;
        };
      };
      sansSerif = lib.mkOption {
        type = inputs.home-manager.lib.hm.types.fontType;
        description = "Sans serif variable width font to use as system default";
        default = {
          name = "SF Pro Text";
          package = inputs.apple-fonts.packages.${system}.sf-pro;
          size = 14;
        };
      };
      emoji = lib.mkOption {
        type = inputs.home-manager.lib.hm.types.fontType;
        description = "Emoji's to use as system default";
        default = {
          name = "Twitter Color Emoji";
          package = pkgs.twitter-color-emoji;
          size = 14;
        };
      };
      nerdFontGlyphs.enable = lib.mkEnableOption "Enable Nerd Font Glyphs";
      extraFonts = lib.mkOption {
        type = lib.types.listOf inputs.home-manager.lib.hm.types.fontType;
        description = "Extra fonts to install";
        default = [ ];
      };
    };

    cursor = lib.mkOption {
      type = lib.types.nullOr (
        lib.types.submodule {
          options = {
            package = lib.mkOption {
              type = lib.types.package;
              default = lib.literalExpression "pkgs.vanilla-dmz";
              description = "Package providing the cursor theme";
            };

            name = lib.mkOption {
              type = lib.types.str;
              default = "Vanilla-DMZ";
              description = "The cursor name within the package";
            };

            size = lib.mkOption {
              type = lib.types.int;
              default = 24;
              example = 64;
              description = "The cursor size";
            };
          };
        }
      );
      description = "Cursor settings";
    };

    style = lib.mkOption {
      type = lib.types.enum [
        "Light"
        "Dark"
      ];
      description = "Whether this theme prefers to match with light or dark color schemes";
    };

    colors = {
      pallete =
        let
          themeColor = lib.types.submodule {
            options = {
              hex = lib.mkOption { type = lib.types.str; };
              rgb = {
                r = lib.mkOption { type = lib.types.numbers 0 255; };
                g = lib.mkOption { type = lib.types.numbers 0 255; };
                b = lib.mkOption { type = lib.types.numbers 0 255; };
              };
              hsl = {
                h = lib.mkOption { type = lib.types.numbers 0 360; };
                s = lib.mkOption { type = lib.types.numbers 0 100; };
                l = lib.mkOption { type = lib.types.numbers 0 100; };
              };
            };
          };
        in
        {
          base00 = lib.mkOption { type = themeColor; };
          base01 = lib.mkOption { type = themeColor; };
          base02 = lib.mkOption { type = themeColor; };
          base03 = lib.mkOption { type = themeColor; };
          base04 = lib.mkOption { type = themeColor; };
          base05 = lib.mkOption { type = themeColor; };
          base06 = lib.mkOption { type = themeColor; };
          base07 = lib.mkOption { type = themeColor; };
          base08 = lib.mkOption { type = themeColor; };
          base09 = lib.mkOption { type = themeColor; };
          base0A = lib.mkOption { type = themeColor; };
          base0B = lib.mkOption { type = themeColor; };
          base0C = lib.mkOption { type = themeColor; };
          base0D = lib.mkOption { type = themeColor; };
          base0E = lib.mkOption { type = themeColor; };
          base0F = lib.mkOption { type = themeColor; };
        };

      accent = lib.mkOption {
        type = lib.types.enum [
          "base00"
          "base01"
          "base02"
          "base03"
          "base04"
          "base05"
          "base06"
          "base07"
          "base08"
          "base09"
          "base0A"
          "base0B"
          "base0C"
          "base0D"
          "base0E"
          "base0F"
        ];
        description = "The accent color to use";
      };
    };
  };

  config = lib.mkIf config.host.theme.enable {
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        emoji = [ config.host.theme.font.emoji.name ];
        sansSerif = [ config.host.theme.font.sansSerif.name ];
        serif = [ config.host.theme.font.serif.name ];
        monospace = [ config.host.theme.font.mono.name ];
      };
    };

    home.packages = [
      config.host.theme.font.mono.package
      config.host.theme.font.serif.package
      config.host.theme.font.sansSerif.package
      config.host.theme.font.emoji.package
    ]
    ++ (if config.host.theme.font.nerdFontGlyphs.enable then [ pkgs.nerd-fonts.symbols-only ] else [ ])
    ++ config.host.theme.font.extraFonts;

    home.pointerCursor = lib.mkIf (config.host.theme.cursor != null) {
      name = config.host.theme.cursor.name;
      package = config.host.theme.cursor.package;
      size = config.host.theme.cursor.size;
      gtk.enable = true;
      x11.enable = true;
    };

    dconf.settings."org/gnome/desktop/interface".color-scheme =
      "prefer-${lib.strings.toLower config.host.theme.style}";

    gtk =
      let
        isDark = config.host.theme.style == "Dark";
      in
      {
        enable = true;
        iconTheme = {
          package = pkgs.gnome-themes-extra;
          name = if isDark then "Adwaita-dark" else "Adwaita";
        };
        theme = {
          package = pkgs.gnome-themes-extra;
          name = if isDark then "Adwaita-dark" else "Adwaita";
        };
      };

    qt =
      let
        isDark = config.host.theme.style == "Dark";
      in
      {
        enable = true;
        platformTheme.name = "adwaita";
        style.name = if isDark then "adwaita-dark" else "adwaita";
      };
  };
}
