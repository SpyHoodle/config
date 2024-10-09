{
  description = "SpyHoodle's personal nix system configurations";

  inputs = {
    # Nixpkgs Unstable
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
    # Nix Darwin
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    
    # Hyprland
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";

    # Any Run
    anyrun.url = "github:Kirottu/anyrun";
    anyrun.inputs.nixpkgs.follows = "nixpkgs";

    # Woomer
    woomer.url = "github:coffeeispower/woomer";
    woomer.inputs.nixpkgs.follows = "nixpkgs";

    # Lix Module
    lix-module.url = "git+https://git.lix.systems/lix-project/nixos-module?ref=refs/tags/2.91.0";
    lix-module.inputs.nixpkgs.follows = "nixpkgs";

    # Neovim configuration
    editor.url = "github:spyhoodle/editor";
    editor.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, nix-darwin, ... } @ inputs:
    let
      username = "maddie";

      nixpkgs_aarch64_darwin = import nixpkgs {
        config.allowUnfree = true;
        system = "aarch64-darwin";
      };
      nixpkgs_x86_64_linux = import nixpkgs {
        config.allowUnfree = true;
        system = "x86_64-linux";
        overlays = import ./overlays.nix;
      };
    in
    {
      nixosConfigurations."desktop" = nixpkgs.lib.nixosSystem
      {
        specialArgs = {
          inherit username;
          inherit inputs;
        };
        pkgs = nixpkgs_x86_64_linux;
        system = "x86_64-linux";
        modules = [
          # Home Manager Modules
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = {
              inherit username;
              inherit inputs;
              pkgs = nixpkgs_x86_64_linux;
            };
            home-manager.users.${username}.imports = [ 
              ./homes/common
              ./homes/desktop
              inputs.anyrun.homeManagerModules.default
            ];
          }

          # NixOS Modules
          ./systems/desktop
          inputs.lix-module.nixosModules.default
        ];
      };

      darwinConfigurations."laptop" = nix-darwin.lib.darwinSystem {
        pkgs = nixpkgs_aarch64_darwin;
        system = "aarch64-darwin";
        specialArgs = {
          inherit username;
          inherit inputs;
        };
        modules = [
          # Home Manager Modules
          home-manager.darwinModules.home-manager
          {
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit username;
              inherit inputs;
              pkgs = nixpkgs_aarch64_darwin;
            };
            home-manager.users.${username}.imports = [
              ./homes/laptop
              ./homes/common
            ];
          }

          # Nix Darwin Modules
          ./systems/laptop
          inputs.lix-module.nixosModules.default
        ];
      };

      formatter.aarch64-darwin = nixpkgs_aarch64_darwin.legacyPackages.aarch64-darwin.nixpkgs-fmt;
      formatter.x86_64-linux = nixpkgs_x86_64_linux.legacyPackages.x86_64-linux.nixpkgs-fmt;
    };
}
