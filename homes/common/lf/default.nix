{ pkgs, ... }:

{
  programs.lf = {
    enable = true;
    previewer.source = ./scope;
    settings = {
      relativenumber = true;
      number = true;
      hidden = false;
      preview = true;
      icons = true;
    };
  };

  xdg.configFile = {
    "lf/icons" = {
      source = ./icons;
    };
  };

  home.packages = with pkgs; [
    ueberzug
    file
  ];
}
