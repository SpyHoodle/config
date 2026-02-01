{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.host.theme.matugen = {
    enable = lib.mkEnableOption "Enable matugen theme generator";
  };

  config = lib.mkIf config.host.theme.matugen.enable {
    host.theme = {
      colors.pallete =
        let
          wallpaper = config.host.theme.wallpaper;
          # Ensure style is lowercase for matugen (dark/light)
          style = lib.strings.toLower config.host.theme.style;

          # Helper to generate a color block
          mkColor = role: ''
            {
              hex = "{{colors.${role}.default.hex_stripped}}";
              rgb = {
                r = {{colors.${role}.default.red}};
                g = {{colors.${role}.default.green}};
                b = {{colors.${role}.default.blue}};
              };
              hsl = {
                h = {{colors.${role}.default.hue}};
                s = {{colors.${role}.default.saturation}};
                l = {{colors.${role}.default.lightness}};
              };
            }
          '';

          # Updated mappings for better contrast and dark/light mode consistency
          # Base08-0F are used for text and Waybar backgrounds (with black text).
          # We use "on_*_container" or standard roles which are Light in Dark mode (Tone 80/90).
          template = ''
            {
              base00 = ${mkColor "surface"};
              base01 = ${mkColor "surface_container"};
              base02 = ${mkColor "surface_container_high"};
              base03 = ${mkColor "surface_variant"};
              base04 = ${mkColor "inverse_surface"};
              base05 = ${mkColor "on_surface"};
              base06 = ${mkColor "inverse_on_surface"};
              base07 = ${mkColor "on_surface_variant"};
              base08 = ${mkColor "error"};
              base09 = ${mkColor "tertiary"};
              base0A = ${mkColor "on_tertiary_container"};
              base0B = ${mkColor "secondary"};
              base0C = ${mkColor "on_secondary_container"};
              base0D = ${mkColor "primary"};
              base0E = ${mkColor "on_primary_container"};
              base0F = ${mkColor "on_surface_variant"};
            }
          '';

          palette =
            pkgs.runCommand "matugen-palette.nix"
              {
                nativeBuildInputs = [ pkgs.matugen ];
                inherit wallpaper;
                passAsFile = [ "template" ];
                template = template;
              }
              ''
                # Create config file
                cat > matugen.toml <<EOF
                [config]
                reload_apps = false
                set_wallpaper = false

                [templates.nix]
                input_path = "$templatePath"
                output_path = "$out"
                EOF

                # Run matugen
                matugen image "$wallpaper" -c matugen.toml -m ${style}
              '';
        in
        import "${palette}";

      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 24;
      };
    };

    gtk =
      let
        wallpaper = config.host.theme.wallpaper;
        style = lib.strings.toLower config.host.theme.style;

        # Define the template within the derivation
        gtkTemplate = pkgs.writeText "gtk.css" ''
          @define-color accent_color {{colors.primary.default.hex}};
          @define-color accent_bg_color {{colors.primary.default.hex}};
          @define-color accent_fg_color {{colors.on_primary.default.hex}};
          @define-color destructive_color {{colors.error.default.hex}};
          @define-color destructive_bg_color {{colors.error.default.hex}};
          @define-color destructive_fg_color {{colors.on_error.default.hex}};
          @define-color success_color {{colors.secondary.default.hex}};
          @define-color success_bg_color {{colors.secondary.default.hex}};
          @define-color success_fg_color {{colors.on_secondary.default.hex}};
          @define-color warning_color {{colors.tertiary.default.hex}};
          @define-color warning_bg_color {{colors.tertiary.default.hex}};
          @define-color warning_fg_color {{colors.on_tertiary.default.hex}};
          @define-color error_color {{colors.error.default.hex}};
          @define-color error_bg_color {{colors.error.default.hex}};
          @define-color error_fg_color {{colors.on_error.default.hex}};
          @define-color window_bg_color {{colors.surface.default.hex}};
          @define-color window_fg_color {{colors.on_surface.default.hex}};
          @define-color view_bg_color {{colors.surface.default.hex}};
          @define-color view_fg_color {{colors.on_surface.default.hex}};
          @define-color sidebar_bg_color {{colors.surface_container.default.hex}};
          @define-color sidebar_fg_color {{colors.on_surface.default.hex}};
          @define-color sidebar_backdrop_color {{colors.surface_container_low.default.hex}};
          @define-color sidebar_border_color {{colors.outline.default.hex}};
          @define-color headerbar_bg_color {{colors.surface.default.hex}};
          @define-color headerbar_fg_color {{colors.on_surface.default.hex}};
          @define-color headerbar_border_color {{colors.outline.default.hex}};
          @define-color headerbar_backdrop_color @window_bg_color;
          @define-color headerbar_shade_color rgba(0, 0, 0, 0.07);
          @define-color card_bg_color {{colors.surface_container_low.default.hex}};
          @define-color card_fg_color {{colors.on_surface.default.hex}};
          @define-color card_shade_color rgba(0, 0, 0, 0.07);
          @define-color popover_bg_color {{colors.surface_container.default.hex}};
          @define-color popover_fg_color {{colors.on_surface.default.hex}};
          @define-color shade_color rgba(0, 0, 0, 0.07);
          @define-color scrollbar_outline_color {{colors.outline.default.hex}};
        '';

        # Derivation to generate GTK CSS files
        gtkCssFiles =
          pkgs.runCommand "matugen-gtk-css"
            {
              nativeBuildInputs = [ pkgs.matugen ];
              inherit wallpaper;
              inherit gtkTemplate;
            }
            ''
              mkdir -p $out/.config/gtk-4.0
              mkdir -p $out/.config/gtk-3.0

              # Create matugen config
              cat > matugen.toml <<EOF
              [config]
              reload_apps = false
              set_wallpaper = false

              [templates.gtk4]
              input_path = "$gtkTemplate"
              output_path = "$out/.config/gtk-4.0/gtk.css"

              [templates.gtk3]
              input_path = "$gtkTemplate"
              output_path = "$out/.config/gtk-3.0/gtk.css"
              EOF

              # Run matugen
              matugen image "$wallpaper" -c matugen.toml -m ${style}
            '';
            in
            {
              enable = true;
              cursorTheme = lib.mkForce {
                package = config.host.theme.cursor.package;
                name = config.host.theme.cursor.name;
                size = config.host.theme.cursor.size;
              };
      
              theme = lib.mkForce {
                name = "adw-gtk3${if style == "dark" then "-dark" else ""}";
                package = pkgs.adw-gtk3;
              };

              iconTheme = lib.mkForce {
                package = pkgs.papirus-icon-theme;
                name = if style == "dark" then "Papirus-Dark" else "Papirus-Light";
              };
              
              gtk4.extraCss = lib.mkForce "@import url(\"${gtkCssFiles}/.config/gtk-4.0/gtk.css\");";
              gtk3.extraCss = lib.mkForce "@import url(\"${gtkCssFiles}/.config/gtk-3.0/gtk.css\");";
            };

    # QT theming with Kvantum using matugen colors
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
    ];

    # Kvantum theme configuration
    xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=MatugenTheme
    '';

    xdg.configFile."Kvantum/MatugenTheme/MatugenTheme.kvconfig".text =
      let
        palette = config.host.theme.colors.pallete;
      in
      ''
        [%General]
        author=Matugen Theme Generator
        comment=Auto-generated from wallpaper colors
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

    xdg.configFile."Kvantum/MatugenTheme/MatugenTheme.svg".source = pkgs.writeText "MatugenTheme.svg" ''
      <svg></svg>
    '';
  };
}
