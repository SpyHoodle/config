{
  host = {
    # Code
    code = {
      python.enable = true;
      rust.enable = true;
    };

    # Theme
    # theme = {
    #   catppuccin.enable = true;
    #   colors.accent = "base0E";
    #   wallpaper = ./wallpapers/nasa.png;
    # };

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

    # Home Manager
    home-manager = {
      enable = true;
      username = "maddie";
      homeDir = "/Users/maddie/";
    };

    # Programs
    programs = {
      # Hyfetch
      hyfetch.enable = true;
      # Eza
      eza.enable = true;
      # Htop
      htop.enable = true;
      # Btop
      btop.enable = true;
    };
  };
}
