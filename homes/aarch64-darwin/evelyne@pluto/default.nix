{
  host = {
    # Code
    code = {
      python.enable = true;
      rust.enable = true;
    };

    # Theme
    theme.enable = false;

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
      userName = "Evelyne Cassidy";
      userEmail = "retroevelyne@outlook.com";
      gpg.key = "C4F179337DB0D43A2ABE8EC900FC03E8D01EA976";
    };

    # Home Manager
    home-manager = {
      enable = true;
      username = "evelyne";
      homeDir = "/Users/evelyne/";
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
