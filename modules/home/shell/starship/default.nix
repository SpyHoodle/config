{ config, lib, ... }:

let
  baseSettings = {
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

    character = {
      success_symbol = lib.mkDefault "-> ${config.host.shell.starship.icon}";
      error_symbol = lib.mkDefault "-> ${config.host.shell.starship.icon}";
      vimcmd_symbol = lib.mkDefault "-> ${config.host.shell.starship.icon}";
    };

    directory.truncation_symbol = ".../";

    git_branch.symbol = " ";

    git_metrics.disabled = false;

    git_status = {
      ahead = "->";
      behind = "<-";
      diverged = "<->";
      renamed = ">>";
      deleted = "x";
    };

    nix_shell.symbol = " ";

    cmd_duration.min_time = 2000;

    memory_usage = {
      disabled = false;
      threshold = 75;
    };

    localip.disabled = false;
  };

  themedSettings =
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

      directory.style = "bold ${cyanColor}";

      git_branch.style = "bold ${magentaColor}";

      git_metrics = {
        added_style = "bold ${greenColor}";
        deleted_style = "bold ${errorColor}";
      };

      git_status.style = "bold ${orangeColor}";

      # Language modules with themed colors
      python.style = "bold ${yellowColor}";
      rust.style = "bold ${orangeColor}";
      nodejs.style = "bold ${greenColor}";
      golang.style = "bold ${cyanColor}";
      java.style = "bold ${errorColor}";
      nix_shell.style = "bold ${blueColor}";

      cmd_duration.style = "bold ${yellowColor}";

      memory_usage.style = "bold ${orangeColor}";

      localip.style = "bold ${greenColor}";

      hostname.style = "bold ${accentColor}";
      username.style_user = "bold ${accentColor}";
    };
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

      settings = lib.mkMerge [
        baseSettings
        (lib.mkIf config.host.theme.enable themedSettings)
      ];
    };
  };
}
