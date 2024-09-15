{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gzdoom
  ];
}
