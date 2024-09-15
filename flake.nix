{
  description = "SpyHoodle Nix Configuration";

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
        specialArgs = { inherit username; inherit inputs; };
        pkgs = nixpkgs_x86_64_linux;
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          {
            home-manager.users.${username}.imports = [ 
              ./homes/common/ssh
              ./homes/common/amfora.nix
              ./homes/common/btop.nix
              ./homes/common/eza.nix
              ./homes/common/fetch.nix
              ./homes/common/git.nix
              ./homes/common/helix.nix
              ./homes/common/htop.nix
              ./homes/common/kakoune
              ./homes/common/latex.nix
              ./homes/common/lf
              ./homes/common/media-tools.nix
              ./homes/common/python.nix
              ./homes/common/rust.nix
              ./homes/common/shell.nix
              ./homes/common/starship.nix
              ./homes/common/tmux.nix
              ./homes/common/wezterm.nix
              ./homes/common/xdg.nix
              ./homes/common/zsh.nix             

              ./homes/desktop/alacritty.nix
              ./homes/desktop/anyrun.nix
              ./homes/desktop/audio.nix
              ./homes/desktop/chromium.nix
              ./homes/desktop/cider.nix
              ./homes/desktop/cursor.nix
              ./homes/desktop/discord.nix
              ./homes/desktop/dmenu.nix
              ./homes/desktop/element.nix
              ./homes/desktop/games.nix
              ./homes/desktop/gtk.nix
              ./homes/desktop/home.nix
              ./homes/desktop/hyprland.nix
              ./homes/desktop/hyprlock.nix
              ./homes/desktop/hyprpaper.nix
              ./homes/desktop/kdeconnect.nix
              ./homes/desktop/kitty.nix
              ./homes/desktop/librewolf.nix
              ./homes/desktop/minecraft.nix
              ./homes/desktop/mpv.nix
              ./homes/desktop/ncdu.nix
              ./homes/desktop/steam.nix
              ./homes/desktop/syncplay.nix
              ./homes/desktop/terminals.nix
              ./homes/desktop/tor-browser.nix
              ./homes/desktop/uxplay.nix
              ./homes/desktop/waybar.nix
              ./homes/desktop/wine.nix
              ./homes/desktop/wlogout.nix
              ./homes/desktop/xdg.nix
              ./homes/desktop/xorg.nix
              ./homes/desktop/zathura.nix

              inputs.anyrun.homeManagerModules.default
            ];
            home-manager.extraSpecialArgs = { inherit username; inherit inputs; pkgs = nixpkgs_x86_64_linux; };
          }

          ./systems/desktop/audio.nix
          ./systems/desktop/avahi.nix
          ./systems/desktop/bluetooth.nix
          ./systems/desktop/boot.nix
          ./systems/desktop/clicks-tailscale.nix
          ./systems/desktop/cpu.nix
          ./systems/desktop/doas.nix
          ./systems/desktop/firewall.nix
          ./systems/desktop/fonts.nix
          ./systems/desktop/gpg.nix
          ./systems/desktop/hardware.nix
          ./systems/desktop/hyprland.nix
          ./systems/desktop/hyprlock.nix
          ./systems/desktop/locale.nix
          ./systems/desktop/ly.nix
          ./systems/desktop/man.nix
          ./systems/desktop/networking.nix
          ./systems/desktop/nix-ld.nix
          ./systems/desktop/nix.nix
          ./systems/desktop/nixos.nix
          ./systems/desktop/nvidia.nix
          ./systems/desktop/packages.nix
          ./systems/desktop/security.nix
          ./systems/desktop/ssh.nix
          ./systems/desktop/systemd.nix
          ./systems/desktop/tailscale.nix
          ./systems/desktop/users.nix
          ./systems/desktop/xdg.nix
          ./systems/desktop/xorg.nix
          ./systems/desktop/yubikey.nix
          ./systems/desktop/zsh.nix
        ];
      };

      darwinConfigurations."laptop" = nix-darwin.lib.darwinSystem {
        pkgs = nixpkgs_aarch64_darwin;
        system = "aarch64-darwin";
        specialArgs = {
          inherit username;
        };
        modules = [
          # Home Manager Modules
          home-manager.darwinModules.home-manager
          {
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit username;
              pkgs = nixpkgs_aarch64_darwin;
            };
            home-manager.users.${username}.imports = [
              ./homes/laptop/home.nix
              ./homes/laptop/ssh.nix
              ./homes/common/ssh
              ./homes/common/amfora.nix
              ./homes/common/btop.nix
              ./homes/common/eza.nix
              ./homes/common/fetch.nix
              ./homes/common/git.nix
              ./homes/common/helix.nix
              ./homes/common/htop.nix
              ./homes/common/kakoune
              ./homes/common/latex.nix
              ./homes/common/lf
              ./homes/common/media-tools.nix
              ./homes/common/python.nix
              ./homes/common/rust.nix
              ./homes/common/shell.nix
              ./homes/common/starship.nix
              ./homes/common/tmux.nix
              ./homes/common/wezterm.nix
              ./homes/common/xdg.nix
              ./homes/common/zsh.nix             
            ];
          }
          # Nix Darwin Modules
          ./systems/laptop/fonts.nix
          ./systems/laptop/gpg.nix
          ./systems/laptop/nix.nix
          ./systems/laptop/packages.nix
          ./systems/laptop/ssh.nix
          ./systems/laptop/sudo.nix
          ./systems/laptop/zsh.nix
        ];
      };
      formatter.aarch64-darwin = nixpkgs_aarch64_darwin.legacyPackages.aarch64-darwin.nixpkgs-fmt;
    };
}
