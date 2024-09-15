{ pkgs, ... }:

{
  home.packages = with pkgs; [
    cool-retro-term # Retro-style terminal
    st # Suckless terminal
  ];
}
