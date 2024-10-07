{ pkgs, lib, inputs, ... }:

{
  nix = {
    package = lib.mkForce inputs.lix-module.packages.${pkgs.stdenv.hostPlatform.system}.default;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
    extraOptions = lib.optionalString (pkgs.system == "aarch64-darwin") ''
      extra-platforms = x86_64-darwin aarch64-darwin
    '';
  };
  services.nix-daemon.enable = true;
}
