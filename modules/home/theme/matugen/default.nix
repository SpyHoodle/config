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

          template = ''
            {
              base00 = ${mkColor "surface"};
              base01 = ${mkColor "surface_container"};
              base02 = ${mkColor "surface_container_high"};
              base03 = ${mkColor "surface_variant"};
              base04 = ${mkColor "on_surface_variant"};
              base05 = ${mkColor "on_surface"};
              base06 = ${mkColor "inverse_on_surface"};
              base07 = ${mkColor "inverse_surface"};
              base08 = ${mkColor "error"};
              base09 = ${mkColor "tertiary"};
              base0A = ${mkColor "tertiary_container"};
              base0B = ${mkColor "secondary"};
              base0C = ${mkColor "secondary_container"};
              base0D = ${mkColor "primary"};
              base0E = ${mkColor "primary_container"};
              base0F = ${mkColor "inverse_primary"};
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
            # We use -m to set the mode (dark/light) matching the system theme
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