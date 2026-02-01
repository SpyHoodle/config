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
      nerdFontGlyphs.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable Nerd Font Glyphs (symbols-only package for icon support)";
      };
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
      default = "Dark";
      description = "Whether this theme prefers to match with light or dark color schemes";
    };

    colors = {
      pallete =
        let
          themeColor = lib.types.submodule {
            options = {
              hex = lib.mkOption { type = lib.types.str; };
              rgb = {
                r = lib.mkOption { type = lib.types.ints.between 0 255; };
                g = lib.mkOption { type = lib.types.ints.between 0 255; };
                b = lib.mkOption { type = lib.types.ints.between 0 255; };
              };
              hsl = {
                h = lib.mkOption { type = lib.types.ints.between 0 360; };
                s = lib.mkOption { type = lib.types.ints.between 0 100; };
                l = lib.mkOption { type = lib.types.ints.between 0 100; };
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
      # QT theming packages
      pkgs.libsForQt5.qtstyleplugin-kvantum
      pkgs.kdePackages.qtstyleplugin-kvantum
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
        palette = config.host.theme.colors.pallete;
      in
      {
        enable = true;
        platformTheme.name = "kvantum";
        style = {
          name = "kvantum";
          package = pkgs.libsForQt5.qtstyleplugin-kvantum;
        };
      };

    # Kvantum theme configuration for QT apps
    xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=CustomTheme
    '';

    xdg.configFile."Kvantum/CustomTheme/CustomTheme.kvconfig".text =
      let
        palette = config.host.theme.colors.pallete;
        isDark = config.host.theme.style == "Dark";
      in
      ''
        [%General]
        author=NixOS Theme Generator
        comment=Auto-generated from Base16 palette
        x11drag=all
        alt_mnemonic=true
        left_tabs=false
        attach_active_tab=false
        mirror_doc_tabs=false
        group_toolbar_buttons=false
        toolbar_item_spacing=0
        toolbar_interior_spacing=2
        spread_progressbar=true
        composite=true
        menu_shadow_depth=7
        spread_menuitems=true
        tooltip_shadow_depth=6
        splitter_width=1
        scroll_width=12
        scroll_arrows=false
        scroll_min_extent=50
        transient_scrollbar=true
        slider_width=4
        slider_handle_width=18
        slider_handle_length=18
        tickless_slider_handle_size=18
        center_toolbar_handle=true
        check_size=16
        textless_progressbar=false
        progressbar_thickness=4
        menubar_mouse_tracking=true
        toolbutton_style=0
        double_click=false
        translucent_windows=false
        blurring=false
        popup_blurring=false
        vertical_spin_indicators=false
        spin_button_width=16
        fill_rubberband=false
        merge_menubar_with_toolbar=false
        small_icon_size=16
        large_icon_size=32
        button_icon_size=16
        toolbar_icon_size=22
        combo_as_lineedit=true
        button_contents_shift=false
        combo_menu=true
        hide_combo_checkboxes=false
        combo_focus_rect=false
        groupbox_top_label=true
        inline_spin_indicators=true
        joined_inactive_tabs=true
        layout_spacing=3
        layout_margin=6
        scrollbar_in_view=false
        tree_branch_line=false
        no_window_pattern=false
        opaque=kaffeine,kmplayer,subtitlecomposer,kdenlive,vlc,smplayer,smplayer2,avidemux,avidemux2_qt4,avidemux3_qt4,avidemux3_qt5,kamoso,QtCreator,VirtualBox,trojita,dragon,digikam
        reduce_window_opacity=0
        respect_darkness=true

        [GeneralColors]
        window.color=#${palette.base00.hex}
        base.color=#${palette.base01.hex}
        alt.base.color=#${palette.base02.hex}
        button.color=#${palette.base02.hex}
        light.color=#${palette.base04.hex}
        mid.light.color=#${palette.base03.hex}
        dark.color=#${palette.base01.hex}
        mid.color=#${palette.base02.hex}
        highlight.color=#${palette.base0D.hex}
        inactive.highlight.color=#${palette.base03.hex}
        text.color=#${palette.base05.hex}
        window.text.color=#${palette.base05.hex}
        button.text.color=#${palette.base05.hex}
        disabled.text.color=#${palette.base03.hex}
        tooltip.text.color=#${palette.base05.hex}
        highlight.text.color=#${palette.base00.hex}
        link.color=#${palette.base0D.hex}
        link.visited.color=#${palette.base0E.hex}
        progress.indicator.text.color=#${palette.base00.hex}

        [Hacks]
        transparent_dolphin_view=false
        transparent_pcmanfm_sidepane=false
        transparent_ktitle_label=true
        transparent_menutitle=true
        respect_darkness=true
        kcapacitybar_as_progressbar=true
        normal_default_pushbutton=true
        iconless_pushbutton=false
        iconless_menu=false
        disabled_icon_opacity=100
        lxqtmainmenu_iconsize=22
        blur_translucent=false
        transparent_arrow_button=true
        middle_click_scroll=false
        no_selection_tint=false
        tint_on_mouseover=0
        scroll_jump_workaround=false
        centered_forms=false
        kinetic_scrolling=false
        noninteger_translucency=false
      '';

    xdg.configFile."Kvantum/CustomTheme/CustomTheme.svg".source = pkgs.writeText "CustomTheme.svg" ''
      <svg></svg>
    '';
  };
}
