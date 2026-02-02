{
  host = {

    # Desktop Environment
    desktop = {
      hyprland = {
        enable = true;
        monitors = [
          "HDMI-A-1, 1920x1080@75, 0x0, 1"
        ];
        startupApps = [
          "sleep 2"
          "discordcanary"
        ];
        hypridle.enable = true;
      };

      # Wlogout
      wlogout.enable = true;

      # Waybar
      waybar.enable = true;

      # Mako
      mako.enable = true;

      # Anyrun
      anyrun.enable = true;

      # Hyprlock
      hyprlock = {
        enable = true;
        monitor = "HDMI-A-1";
      };
    };

    # Input
    input.keyboard = {
      layout = "gb";
      variant = "";
      appleMagic.enable = false;
    };
    input.mouse = {
      scrolling.natural = false;
      sensitivity = 0.6;
    };

    # Code
    code = {
      python.enable = true;
      rust.enable = true;
    };

    # Theme
    theme = {
      enable = true;
      style = "Dark";
      catppuccin = {
        enable = true;
        style = "Mocha";
      };
      onedark.enable = false;
      matugen.enable = false;
      colors.accent = "base0E";
      wallpaper = ./wallpapers/catppuccin.png;
    };

    # Shell
    shell = {
      zsh.enable = true;
      starship = {
        enable = true;
        icon = " ";
      };
      aliases.enable = true;
      direnv.enable = true;
    };

    # Neovim
    editor.neovim = {
      enable = true;
      defaultEditor = false;
    };

    # Git
    git = {
      enable = true;
      userName = "Eveleyne Cassidy";
      userEmail = "retroevelyne@outlook.com";
      gpg = {
        enable = true;
        key = "C4F179337DB0D43A2ABE8EC900FC03E8D01EA976";
      };
    };

    # XDG
    xdgCleanup.enable = true;

    # Home Manager
    home-manager = {
      enable = true;
      username = "evelyne";
      homeDir = "/home/evelyne/";
    };

    # Terminal
    terminal.alacritty = {
      enable = true;
      defaultTerminal = true;
    };

    # Chromium
    browser.chromium = {
      enable = true;
      defaultBrowser = true;
    };

    # Tor Browser
    browser.tor-browser.enable = true;

    # Games
    games = {
      # Minecraft
      minecraft.enable = true;

      # osu!
      osu.enable = true;

      # Tetrio
      tetrio.enable = true;
    };

    # Programs
    programs = {
      # Gemini
      gemini.enable = true;

      # Hyfetch
      hyfetch.enable = true;

      # JetBrains
      jetbrains.enable = true;

      # Discord
      discord.enable = true;

      # Element
      element.enable = true;

      # Obsidian
      obsidian.enable = true;

      # Nautilus
      nautilus.enable = true;

      # Eza
      eza.enable = true;

      # Helvum
      helvum.enable = true;

      # Ncdu
      ncdu.enable = true;

      # Mpv
      mpv.enable = true;

      # Oculante
      oculante.enable = true;

      # Kdeconnect
      kdeconnect.enable = true;

      # Zathura
      zathura.enable = true;

      # OBS Studio
      obs-studio.enable = true;

      # Spotify
      spotify.enable = true;

      # Cava
      cava.enable = true;

      # Htop
      htop.enable = true;

      # Btop
      btop = {
        enable = true;
        gpu = {
          enable = true;
          name = "Radeon RX 6600XT";
        };
      };

      # NH
      nh = {
        enable = true;
        garbageCollection.enable = true;
      };

      # Chromium Web Apps
      chromium = {
        chatgpt.enable = true;
        gemini.enable = true;
        icloud.enable = true;
        icloud-drive.enable = true;
        icloud-notes.enable = true;
        photopea.enable = true;
        github-copilot.enable = true;
        search-nixos.enable = true;
        search-nixos-options.enable = true;
        ollama.enable = true;
      };
    };

    # Editor
    editor = {
      # VSCode
      vscode.enable = true;

      # Zed
      zed = {
        enable = true;
        defaultEditor = true;
      };
    };
  };
}
