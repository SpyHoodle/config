{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    killall
    dosfstools
    zip
    unzip
    unrar
    p7zip
    ripgrep
    wget
    fzf
    bat
    git
  ];
}
