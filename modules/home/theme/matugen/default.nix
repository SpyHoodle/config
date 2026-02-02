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

    # Note: QT theming with Kvantum does not work well with matugen-generated colors
    # The generated Kvantum themes have issues with SVG styling and color application.
    # Using Adwaita for QT instead for better compatibility.
    qt = lib.mkForce {
      enable = true;
      platformTheme.name = "adwaita";
      style.name = if config.host.theme.style == "Dark" then "adwaita-dark" else "adwaita";
    };
  };
}
