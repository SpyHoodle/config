{ lib, ... }:

{
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
        success_symbol = "-> [λ](bold purple)";
        error_symbol = "-> [λ](bold red)";
        vimcmd_symbol = "-> [λ](bold green)";
      };

      directory.truncation_symbol = ".../";

      git_metrics.disabled = false;
      git_status = {
        ahead = "->";
        behind = "<-";
        diverged = "<->";
        renamed = ">>";
        deleted = "x";
      };

      memory_usage.disabled = false;
      localip.disabled = false;
    };
  };
}
