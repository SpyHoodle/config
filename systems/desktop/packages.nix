{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Xorg packages
    xorg.xinit
    xorg.xkill
    xorg.xprop
    xorg.xwininfo
    xorg.xrandr
    xdotool
    xclip

    # Processes
    killall
    appimage-run

    # Filesystems
    dosfstools
    btrfs-progs
    ntfs3g
    exfatprogs
    libimobiledevice
    ifuse

    # Archives
    zip
    unrar
    unzip
    p7zip

    # Cli tools
    ripgrep
    wget
    fzf
    bat

    # XDG
    xdg-utils
    xdg-user-dirs

    # Git
    git

    # Compiler
    gcc
  ];
}
