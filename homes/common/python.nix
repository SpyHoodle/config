{ pkgs, ... }:

{
  home.packages = with pkgs; [
    python312Full
  ];
}
