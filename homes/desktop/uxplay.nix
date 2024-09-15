{ pkgs, ... }:

{
  home.packages = with pkgs; [
    uxplay
  ];
}
