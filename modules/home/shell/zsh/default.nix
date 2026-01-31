{ config, lib, pkgs, ... }:

{
  options = {
    host.shell.zsh.enable = lib.mkEnableOption "Enable zsh as the default shell";
  };

  config = lib.mkIf config.host.shell.zsh.enable {
    programs.zsh = {
      enable = true;

      autosuggestion.enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      autocd = true;

      plugins = [
        {
          name = "zsh-nix-shell";
          file = "nix-shell.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "chisui";
            repo = "zsh-nix-shell";
            rev = "v0.8.0";
            hash = "sha256-Z6EYQdasvpl1P78poj9efnnLj7QQg13Me8x1Ryyw+dM=";
          };
        }
      ];

      dotDir = "${config.xdg.configHome}/zsh";
      history = {
        size = 9999999;
        expireDuplicatesFirst = true;
        extended = true;
        path = "${config.xdg.cacheHome}/zsh/history";
      };

      initContent = ''
        # Run fastfetch if enabled
        ${lib.optionalString config.host.programs.fastfetch.enable "fastfetch"}

        # Disable Ctrl-S to freeze terminal
        stty stop undef

        # Tab completion
        zstyle ':completion:*' menu select # Use a menu
        _comp_options+=(globdots)          # Include hidden files

        # Change cursor shape for different vi modes
        export KEYTIMEOUT=1
        function zle-keymap-select () {
            case $KEYMAP in
                vicmd) echo -ne '\e[1 q';;      # block
                viins|main) echo -ne '\e[5 q';; # beam
            esac
        }
        zle -N zle-keymap-select
        zle-line-init() {
            zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
            echo -ne "\e[5 q"
        }
        zle -N zle-line-init
        echo -ne '\e[5 q' # Use beam shape cursor on startup.
        preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
      '';
    };
  };
}
