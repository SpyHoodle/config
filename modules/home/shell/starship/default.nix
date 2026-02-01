{ config, lib, ... }:

let
  palette = config.host.theme.colors.pallete;
  accent = config.host.theme.colors.accent;
  # Convert hex to starship color format
  accentColor = "#${palette.${accent}.hex}";
  errorColor = "#${palette.base08.hex}";
  blueColor = "#${palette.base0D.hex}";
  greenColor = "#${palette.base0B.hex}";
  yellowColor = "#${palette.base0A.hex}";
  cyanColor = "#${palette.base0C.hex}";
  orangeColor = "#${palette.base09.hex}";
  magentaColor = "#${palette.base0E.hex}";
in
{
  options = {
    host.shell.starship.enable = lib.mkEnableOption "Enable Starship, a minimal, blazing-fast, and infinitely customizable prompt for any shell";
    host.shell.starship.icon = lib.mkOption {
      type = lib.types.str;
      default = "λ";
      description = "The icon to display in the prompt";
    };
  };

  config = lib.mkIf config.host.shell.starship.enable {
    programs.starship = {
      enable = true;
      enableZshIntegration = true;

      settings = {
        format = lib.concatStrings [
          "$directory"

          "$git_branch"
          "$git_commit"
          "$git_state"
          "$git_metrics"
          "$git_status"
          "$hg_branch"

          "$package"
          "$c"
          "$rust"
          "$golang"
          "$haskell"
          "$python"
          "$java"
          "$kotlin"
          "$lua"
          "$dart"
          "$nim"
          "$nodejs"
          "$swift"
          "$zig"
          "$nix_shell"
          "$conda"
          "$spack"

          "$line_break"
          "$username"
          "$hostname"
          "$localip"
          "$cmd_duration"
          "$memory_usage"
          "$jobs"
          "$character"
        ];

        # Palette for module styling
        palette = "custom";
        palettes.custom = {
          accent = accentColor;
          error = errorColor;
          blue = blueColor;
          green = greenColor;
          yellow = yellowColor;
          cyan = cyanColor;
          orange = orangeColor;
          magenta = magentaColor;
        };

        character = {
          success_symbol = "-> [${config.host.shell.starship.icon}](bold ${accentColor})";
          error_symbol = "-> [${config.host.shell.starship.icon}](bold ${errorColor})";
          vimcmd_symbol = "-> [${config.host.shell.starship.icon}](bold ${blueColor})";
        };

        directory = {
          truncation_symbol = ".../";
          style = "bold ${cyanColor}";
        };

        git_branch = {
          symbol = " ";
          style = "bold ${magentaColor}";
        };

        git_metrics = {
          disabled = false;
          added_style = "bold ${greenColor}";
          deleted_style = "bold ${errorColor}";
        };

        git_status = {
          ahead = "->";
          behind = "<-";
          diverged = "<->";
          renamed = ">>";
          deleted = "x";
          style = "bold ${orangeColor}";
        };

        # Language modules with themed colors
        python.style = "bold ${yellowColor}";
        rust.style = "bold ${orangeColor}";
        nodejs.style = "bold ${greenColor}";
        golang.style = "bold ${cyanColor}";
        java.style = "bold ${errorColor}";
        nix_shell = {
          symbol = " ";
          style = "bold ${blueColor}";
        };

        cmd_duration = {
          min_time = 2000;
          style = "bold ${yellowColor}";
        };

        memory_usage = {
          disabled = false;
          threshold = 75;
          style = "bold ${orangeColor}";
        };

        localip = {
          disabled = false;
          style = "bold ${greenColor}";
        };

        hostname.style = "bold ${accentColor}";
        username.style_user = "bold ${accentColor}";
      };
    };
  };
}
