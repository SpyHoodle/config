{ pkgs, ... }:

{
  gtk = {
    enable = true;
    font = {
      package = pkgs.inter;
      name = "Inter";
      size = 11;
    };
    theme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita-dark";
    };
    iconTheme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  }; 

  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style.name = "adwaita-dark";
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };
}
