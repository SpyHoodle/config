{ pkgs, ... }:

{
  home.packages = with pkgs; [
    amfora
  ];
}
