{
  config,
  lib,
  inputs,
  system,
  ...
}:

{
  options = {
    host.nix.lix.enable = lib.mkEnableOption "Enable Lix, a modern implementation of the Nix package manager";
  };

  config = lib.mkIf config.host.nix.lix.enable {
    nix.package = inputs.lix-module.packages.${system}.default;
  };
}
