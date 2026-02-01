{
  config,
  lib,
  ...
}:

{
  options = {
    host.programs.zed.enable = lib.mkEnableOption "Enable Zed, a fast code editor";
  };

  config = lib.mkIf config.host.programs.zed.enable {
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
        # Appearance
        buffer_font_family = "Iosevka Nerd Font Mono";
        buffer_font_size = 16;
        ui_font_family = "Iosevka Nerd Font Mono";
        ui_font_size = 17;
        agent_font_family = "Iosevka Nerd Font Mono";
        agent_font_size = 17;
        tabs = {
          file_icons = true;
          git_status = true;
          show_diagnostics = "errors";
        };
        title_bar = {
          show_branch_icon = true;
          show_onboarding_banner = false;
        };
        status_bar = {
          show_git_branch = true;
          show_file_path = true;
        };
        minimap = {
          show = "always";
        };

        # Theme
        theme = {
          mode = "system";
          light = "Fleet Light";
          dark = "Fleet Dark";
        };

        # Editor
        base_keymap = "VSCode";
        vim_mode = true;
        relative_line_numbers = true;
        preferred_line_length = 160;
        show_wrap_guides = true;
        tab_size = 2;
        indent_guides = {
          enabled = true;
          coloring = "fixed";
        };
        inlay_hints = {
          enabled = true;
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

        # Languages
        languages = {
          Python = {
            tab_size = 4;
          };
        };

        # Terminal
        terminal = {
          font_family = "Iosevka Nerd Font";
          font_size = 17;
          cursor_shape = "bar";
          copy_on_select = true;
          env = {
            EDITOR = "zed --wait";
          };
        };

        # AI Agent
        agent = {
          enabled = true;
          version = "2";
          default_model = {
            provider = "copilot_chat";
            model = "claude-sonnet-4";
          };
        };
        features = {
          edit_prediction_provider = "copilot";
        };

        # Git
        git = {
          git_gutter = "tracked_files";
        };

        # Saving
        autosave = {
          after_delay = {
            milliseconds = 1000;
          };
        };
        ensure_final_newline_on_save = true;
        remove_trailing_whitespace_on_save = true;
        format_on_save = "on";

        # Application
        confirm_quit = true;
        restore_on_startup = "last_session";

        # Extensions
        auto_install_extensions = {
          html = true;
          nix = true;
          latex = true;
          java = true;
          catppuccin = true;
          fleet-themes = true;
          discord_presence = true;
        };

        # Telemetry
        telemetry = {
          diagnostics = false;
          metrics = false;
        };
      };
    };
  };
}
