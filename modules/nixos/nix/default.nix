{
  config,
  lib,
  system,
  ...
}:

{
  options = {
    host.nix.caches.enable = lib.mkEnableOption "Enable the recommended Nix caches and substituters";
    host.nix.experimentalFeatures.enable = lib.mkEnableOption "Enable the recommended experimental features in Nix";
    host.nix.garbageCollection.enable = lib.mkEnableOption "Enable the recommended garbage collection settings";
  };
  config = {
    nix.settings = {
      builders-use-substitutes = lib.mkIf config.host.nix.caches.enable true;

      substituters = lib.mkIf config.host.nix.caches.enable [
        "https://anyrun.cachix.org/"
        "https://cache.lix.systems/"
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org/"
        "https://hyprland.cachix.org/"
      ];

      trusted-public-keys = lib.mkIf config.host.nix.caches.enable [
        "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
        "cache.lix.systems:aBnZUw8zA7H35Cz2RyKFVs3H4PlGTLawyY5KRbvJR8o="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];

      experimental-features = lib.mkIf config.host.nix.experimentalFeatures.enable [
        "nix-command"
        "flakes"
      ];

      auto-optimise-store = true;
    };

    nix.gc = lib.mkIf config.host.nix.garbageCollection.enable {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    nixpkgs.hostPlatform = system;
    system.stateVersion = "25.05";
  };
}
