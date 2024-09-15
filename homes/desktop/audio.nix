{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pulsemixer # TUI sound mixer
    playerctl # Manages media players
    pamixer # CLI sound mixer
    cava # Music visualiser
  ];
}
