{ pkgs, ... }:

{
  home.packages = with pkgs; [
    imagemagick
    libheif
    ffmpeg
  ];
}
