{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pridefetch
    neofetch
    pfetch
  ];
}
