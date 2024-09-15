{ pkgs, ... }:

{
  programs.kakoune = {
    enable = true;
    config = {
      colorScheme = "one-dark";
      showWhitespace.enable = false;
      scrollOff.lines = 3;
      tabStop = 4;
      numberLines = {
        enable = true;
        relative = true;
      };
      ui = {
        statusLine = "top";
        assistant = "cat";
        enableMouse = true;
        setTitle = true;
      };
      hooks = [
        {
          name = "WinSetOption";
          option = "filetype=nix";
          commands = ''
            set-option window indentwidth 2
            set-option window formatcmd nixpkgs-fmt
          '';
        }
      ];
    };
    plugins = with pkgs.kakounePlugins; [
      kakoune-rainbow
      powerline-kak
      auto-pairs-kak
      pkgs.kak-lsp
    ];
    extraConfig = ''
      # Tabs
      hook global InsertChar \t %{ exec -draft h@ }
      add-highlighter global/ show-whitespaces -tab '│' -tabpad '╌'

      # Kak-LSP
      eval %sh{kak-lsp --kakoune -s $kak_session}
      lsp-enable

      # Modeline
      declare-option bool lsp_enabled false
      declare-option -hidden str lsp_modeline_progress ""
      define-command -hidden -params 6 -override lsp-handle-progress %{
        set-option global lsp_modeline_progress %sh{
            if ! "$6"; then
                echo "$2\$\{5:+" ($5%)"}\$\{4:+": $4"}"
            fi
        }
      }

      declare-option -hidden str modeline_git_branch
      hook global WinDisplay .* %{
        set-option window modeline_git_branch %sh{
            branch=$(git -C "\$\{kak_buffile%/*}" rev-parse --abbrev-ref HEAD 2>/dev/null)
            if [ -n "$branch" ]; then
                printf "$branch "
            fi
        }
      }

      set-option global modelinefmt '%opt{lsp_modeline_progress} {StatusLine}{string}%opt{modeline_git_branch}{type}%sh{ [ -n "$kak_opt_filetype" ] && echo "$kak_opt_filetype " }{default}%val{bufname}{{context_info}}{default} {{mode_info}} {meta}%val{cursor_line}:%val{cursor_char_column}'
    '';
  };

  xdg.configFile."kak/colors" = {
    source = ./colors;
    recursive = true;
  };
}
