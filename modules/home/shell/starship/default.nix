{ config, lib, ... }:

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

        character = {
          success_symbol = "-> [${config.host.shell.starship.icon}](bold green)";
          error_symbol = "-> [${config.host.shell.starship.icon}](bold red)";
          vimcmd_symbol = "-> [${config.host.shell.starship.icon}](bold blue)";
        };

        directory = {
          truncation_symbol = ".../";
        };

        git_branch = {
          symbol = " ";
        };

        git_metrics = {
          disabled = false;
        };

        git_status = {
          ahead = "->";
          behind = "<-";
          diverged = "<->";
          renamed = ">>";
          deleted = "x";
        };

        nix_shell = {
          symbol = " ";
        };

        cmd_duration = {
          min_time = 2000;
        };

        memory_usage = {
          disabled = false;
          threshold = 75;
        };

        localip = {
          disabled = false;
        };
      };
    };
  };
}
