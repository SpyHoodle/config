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

          palette = pkgs.runCommand "matugen-palette.nix" {
            nativeBuildInputs = [ pkgs.matugen ];
            inherit wallpaper;
            passAsFile = [ "template" ];
            template = template;
          } ''
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
        
        # Derivation to generate GTK theme
        gtkTheme = pkgs.runCommand "matugen-gtk-theme" {
            nativeBuildInputs = [ pkgs.matugen ];
            inherit wallpaper;
          } ''
            mkdir -p $out/share/themes/Matugen-${style}
            export HOME=$(pwd)
            
            # Create dummy config directories
            mkdir -p $HOME/.config/gtk-4.0
            mkdir -p $HOME/.config/gtk-3.0
            
            # Run matugen to generate GTK3 and GTK4 themes
            # We assume 'adw-gtk3' and 'adw-gtk4' or similar templates exist or fallback to default
            # Using -t gtk3 -t gtk4 to attempt generation
            
            matugen image "$wallpaper" -m ${style} -t adw-gtk3 -t adw-gtk4 || matugen image "$wallpaper" -m ${style} -t gtk3 -t gtk4
            
            # Move generated files to output directory
            if [ -d $HOME/.config/gtk-4.0 ]; then
               mkdir -p $out/share/themes/Matugen-${style}/gtk-4.0
               cp -r $HOME/.config/gtk-4.0/* $out/share/themes/Matugen-${style}/gtk-4.0/
            fi
            
            if [ -d $HOME/.config/gtk-3.0 ]; then
               mkdir -p $out/share/themes/Matugen-${style}/gtk-3.0
               cp -r $HOME/.config/gtk-3.0/* $out/share/themes/Matugen-${style}/gtk-3.0/
            fi
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
          package = gtkTheme;
          name = "Matugen-${style}";
        };
      };
  };
}
