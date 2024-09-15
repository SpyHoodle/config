{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    nerdfonts
    font-awesome
    source-sans
    source-han-sans
    source-han-serif
    source-han-code-jp
    terminus_font
    inter
  ];
}
