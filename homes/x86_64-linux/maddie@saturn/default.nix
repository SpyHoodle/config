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
        startupApps = [
          "sleep 2"
          "openrgb --device 'Razer Huntsman' --mode static --color FFFFFF --brightness 100"
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
      hyprlock.enable = true;
    };

    # Input
    input.keyboard = {
      layout = "gb";
      variant = "";
      appleMagic.enable = false;
    };
    input.trackpad = {
      gestures.enable = true;
      scrolling.natural = true;
      tapToClick = false;
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
      catppuccin.enable = false;
      onedark.enable = true;
      colors.accent = "base0D";
      wallpaper = ./wallpapers/kita.png;
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
      # Minecraft
      minecraft.enable = true;

      # osu!
      osu.enable = true;

      # Tetrio
      tetrio.enable = true;
    };

    # Programs
    programs = {
      # Hyfetch
      hyfetch.enable = true;

      # VSCode
      vscode.enable = true;

      # Discord
      discord.enable = true;

      # Element
      element.enable = true;

      # Obsidian
      obsidian.enable = true;

      # Remmina
      remmina.enable = true;

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

      # Chromium Web Apps
      chromium = {
        chatgpt.enable = true;
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
  };
}
