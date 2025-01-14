{
  host = {

    # Desktop Environment
    desktop = {
      hyprland = {
        enable = true;
        monitors = [
          "DP-2, 2560x1440@1440, 0x0, 1"
          "HDMI-A-1, 1920x1080@75, 2560x0, 1"
        ];
      };

      # Waybar
      waybar.enable = true;

      # Mako
      mako.enable = true;

      # Anyrun
      anyrun.enable = true;

      # Hyprlock
      hyprlock.enable = true;
    };

    # Theme
    theme = {
      enable = true;
      catppuccin.enable = true;
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
    };

    # Neovim
    editor.neovim = {
      enable = true;
      defaultEditor = true;
    };

    # Git
    git = {
      enable = true;
      userName = "Eveleyne Cassidy";
      userEmail = "retroevelyne@outlook.com";
      gpg.key = "C4F179337DB0D43A2ABE8EC900FC03E8D01EA976";
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

      # Osu!
      osu.enable = true;

      # Tetrio
      tetrio.enable = true;
    };

    # Programs
    programs = {
      # Hyfetch
      hyfetch.enable = true;

      # Discord
      discord.enable = true;

      # Element
      element.enable = true;

      # Obsidian
      obsidian.enable = true;

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
          name = "Radeon RX 7900XT";
        };
      };
    };
  };
}
