{
  config,
  lib,
  ...
}:

{
  options = {
    host.editor.zed.enable = lib.mkEnableOption "Enable Zed, a fast code editor";
    host.editor.zed.defaultEditor = lib.mkEnableOption "Set Zed as the default editor";
  };

  config = lib.mkIf config.host.editor.zed.enable {
    programs.zed-editor = {
      enable = true;
      extensions = [
        "html"
        "nix"
        "latex"
        "java"
        "catppuccin"
        "fleet-themes"
        "discord_presence"
      ];

          userSettings = {
            vim_mode = true;
            base_keymap = "VSCode";
            ui_font_size = 17;
            buffer_font_size = 16;
            theme = {
              mode = "dark";
              light = "Fleet Light";
              dark = "Fleet Dark";
            };
            agent = {
              default_model = {
                model = "claude-sonnet-4";
                provider = "copilot_chat";
              };
              enabled = true;
            };
            agent_font_family = "Iosevka Nerd Font Mono";
            agent_ui_font_size = 17;
            auto_install_extensions = {
              catppuccin = true;
              discord_presence = true;
              fleet-themes = true;
              html = true;
              java = true;
              latex = true;
              nix = true;
            };
            autosave = {
              after_delay = {
                milliseconds = 1000;
              };
            };
            buffer_font_family = "Iosevka Nerd Font Mono";
            confirm_quit = true;
            ensure_final_newline_on_save = true;
            features = {
              edit_prediction_provider = "copilot";
            };
            file_scan_exclusions = [
              "**/.git"
              "**/node_modules"
              "**/target"
              "**/.next"
              "**/dist"
              "**/.vscode"
              "**/.idea"
              "**/build"
              "**/out"
              "**/coverage"
              "**/.DS_Store"
              "**/.env"
              "**/.venv"
              "**/.pytest_cache"
              "**/__pycache__"
              "**/venv"
            ];
            format_on_save = "on";
            git = {
              git_gutter = "tracked_files";
            };
            indent_guides = {
              coloring = "fixed";
              enabled = true;
            };
            inlay_hints = {
              enabled = true;
            };
            languages = {
              Python = {
                tab_size = 4;
              };
            };
            minimap = {
              show = "always";
            };
            preferred_line_length = 160;
            relative_line_numbers = "enabled";
            remove_trailing_whitespace_on_save = true;
            restore_on_startup = "last_session";
            show_wrap_guides = true;
            status_bar = {
              show_file_path = true;
              show_git_branch = true;
            };
            tab_size = 2;
            tabs = {
              file_icons = true;
              git_status = true;
              show_diagnostics = "errors";
            };
            telemetry = {
              diagnostics = false;
              metrics = false;
            };
            terminal = {
              copy_on_select = true;
              cursor_shape = "bar";
              env = {
                EDITOR = "zed --wait";
              };
              font_family = "Iosevka Nerd Font";
              font_size = 17;
            };
            title_bar = {
              show_branch_icon = true;
              show_onboarding_banner = false;
            };
            ui_font_family = "Iosevka Nerd Font Mono";
          };
        };

        home.sessionVariables = lib.mkIf config.host.editor.zed.defaultEditor {
          EDITOR = "zed --wait";
          VISUAL = "zed --wait";
        };

        xdg.mimeApps = lib.mkIf config.host.editor.zed.defaultEditor {
          enable = true;
          defaultApplications = {
            "text/plain" = lib.mkDefault [ "dev.zed.Zed.desktop" ];
            "text/markdown" = lib.mkDefault [ "dev.zed.Zed.desktop" ];
            "text/x-nix" = lib.mkDefault [ "dev.zed.Zed.desktop" ];
            "text/x-python" = lib.mkDefault [ "dev.zed.Zed.desktop" ];
            "text/x-rust" = lib.mkDefault [ "dev.zed.Zed.desktop" ];
            "text/x-java" = lib.mkDefault [ "dev.zed.Zed.desktop" ];
            "text/x-c" = lib.mkDefault [ "dev.zed.Zed.desktop" ];
            "text/x-c++" = lib.mkDefault [ "dev.zed.Zed.desktop" ];
            "text/x-go" = lib.mkDefault [ "dev.zed.Zed.desktop" ];
            "text/x-shellscript" = lib.mkDefault [ "dev.zed.Zed.desktop" ];
            "text/x-sh" = lib.mkDefault [ "dev.zed.Zed.desktop" ];
            "text/x-zsh" = lib.mkDefault [ "dev.zed.Zed.desktop" ];
            "text/x-toml" = lib.mkDefault [ "dev.zed.Zed.desktop" ];
            "text/yaml" = lib.mkDefault [ "dev.zed.Zed.desktop" ];
            "application/x-yaml" = lib.mkDefault [ "dev.zed.Zed.desktop" ];
            "application/json" = lib.mkDefault [ "dev.zed.Zed.desktop" ];
            "text/x-tex" = lib.mkDefault [ "dev.zed.Zed.desktop" ];
            "text/x-cmake" = lib.mkDefault [ "dev.zed.Zed.desktop" ];
            "text/x-ini" = lib.mkDefault [ "dev.zed.Zed.desktop" ];
            "text/html" = lib.mkDefault [ "dev.zed.Zed.desktop" ];
            "text/css" = lib.mkDefault [ "dev.zed.Zed.desktop" ];
            "application/javascript" = lib.mkDefault [ "dev.zed.Zed.desktop" ];
            "text/javascript" = lib.mkDefault [ "dev.zed.Zed.desktop" ];
            "application/x-typescript" = lib.mkDefault [ "dev.zed.Zed.desktop" ];
            "text/x-typescript" = lib.mkDefault [ "dev.zed.Zed.desktop" ];
          };
        };
      };
}
