{
  # Snowfall Lib provides a customized `lib` instance with access to your flake's library
  # as well as the libraries available from your flake's inputs.
  lib,
  # An instance of `pkgs` with your overlays and packages applied is also available.
  pkgs,
  # You also have access to your flake's inputs.
  inputs,

  # Additional metadata is provided by Snowfall Lib.
  internal, # The namespace used for your flake, defaulting to "internal" if not set.
  system, # The system architecture for this host (eg. `x86_64-linux`).
  target, # The Snowfall Lib target for this system (eg. `x86_64-iso`).
  format, # A normalized name for the system target (eg. `iso`).
  virtual, # A boolean to determine whether this system is a virtual target using nixos-generators.
  systems, # An attribute map of your defined hosts.

  # All other arguments come from the system system.
  config,
  ...
}:

{
  imports = [
    ./hardware
  ];

  host = {
    # Audio
    audio.pipewire.enable = true;

    # Networking
    networking = {
      enable = true;
      hostName = "desktop";
      useDHCP = true;
      wireless = {
        enable = true;
        networks = {
          "BT-C5CPMR" = {
            psk = "hN3LtFrkp36bXc";
          };
        };
      };
      firewall = {
        enable = true;
        allowedTCPPorts = [ ];
      };
      avahi.enable = false;
    };

    # Bluetooth
    bluetooth.enable = true;

    # Boot
    boot = {
      systemd.enable = true;
      sysrq.enable = true;
      linuxZen.enable = true;
      kernelParams = [ "video=2560x1440@200" ];
    };

    # Desktop Environment
    desktop = {
      # Hyprland
      hyprland.enable = true;

      # Ly Display Manager
      ly.enable = true;
    };

    # Doas
    doas.enable = true;

    # Graphics
    graphics.enable = true;

    # Input
    input.keyboard.layout = "uk";

    # Locale
    locale = {
      timeZone = "Europe/London";
      locale = "en_GB.UTF-8";
    };

    # Nix
    nix = {
      lix.enable = true;
      caches.enable = true;
      experimentalFeatures.enable = true;
      garbageCollection.enable = true;
    };

    # Main User
    user = {
      enable = true;
      name = "maddie";
      fullName = "Madeleine";
      shell = pkgs.zsh;
    };

    # Programs
    programs = {
      nix-ld.enable = true;
      pager.enable = true;
      xdg-open.enable = true;
      tools.enable = true;
      shell.zsh.enable = true;
      ollama.enable = true;
      steam.enable = true;
      coolercontrol.enable = true;
    };

    # Services
    services = {
      openrgb.enable = true;
      openrazer.enable = true;
      gnupg.enable = true;
    };

    # YubiKey Integration
    yubikey.enable = true;
  };
}
