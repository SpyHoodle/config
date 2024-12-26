{
  host = {

    # Desktop Environment
    desktop = {
      hyprland = {
        enable = true;
        monitors = [
          "DP-1, 2560x1440@200, 2560x0, 1"
          "DP-2, 2560x1440@200, 0x0, 1"
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
      catppuccin.enable = true;
      colors.accent = "base0E";
      wallpaper = ./wallpapers/catppuccin.png;
    };

    # Shell
    shell = {
      zsh.enable = true;
      starship.enable = true;
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
      userName = "Madeleine Holbrook";
      userEmail = "maddie@spyhoodle.me";
      gpg.key = "FA50688B9EB6D8AA070C8241C296DE8C9053683F";
    };

    # XDG
    xdgCleanup.enable = true;

    # Home Manager
    home-manager = {
      enable = true;
      username = "maddie";
      homeDir = "/home/maddie/";
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
      minecraft.enable = true;
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

      # Cava
      cava.enable = true;

      # Htop
      htop.enable = true;

      # Btop
      btop = {
        enable = true;
        gpuName = "Radeon RX 7900XT";
      };
    };
  };
}
