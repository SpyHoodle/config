{
  description = "SpyHoodle's Personal NixOS Configuration";

  inputs = {
    # Nixpkgs Unstable
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # Snowfall Lib
    snowfall-lib.url = "github:snowfallorg/lib/dev";
    snowfall-lib.inputs.nixpkgs.follows = "nixpkgs";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Nix Darwin
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Any Run
    anyrun.url = "github:Kirottu/anyrun";
    anyrun.inputs.nixpkgs.follows = "nixpkgs";

    # Woomer
    woomer.url = "github:coffeeispower/woomer";
    woomer.inputs.nixpkgs.follows = "nixpkgs";

    # Astal
    astal.url = "github:aylur/astal";
    astal.inputs.nixpkgs.follows = "nixpkgs";

    # My NeoVim Configuration
    editor.url = "github:spyhoodle/editor";
    editor.inputs.nixpkgs.follows = "nixpkgs";

    # Apple Fonts
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
    apple-fonts.inputs.nixpkgs.follows = "nixpkgs";

    # Hyprland
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;
      inherit nixpkgs;
      src = ./.;

      homes.modules = [
        (
          { modulesPath, ... }:
          {
            disabledModules = [ "${modulesPath}/programs/anyrun.nix" ];
          }
        )
        inputs.anyrun.homeManagerModules.default
      ];

      systems.modules.nixos = [
      ];

      snowfall = {
        namespace = "host";
        meta.name = "Host";
        meta.title = "My custom modules";
      };

      outputs-builder = channels: {
        formatter = nixpkgs.legacyPackages.${channels.nixpkgs.system}.nixfmt-rfc-style;
      };

      channels-config = {
        allowUnfree = true;
      };
    };
}
