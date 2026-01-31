{
  pkgs,
  lib,
  config,
  inputs,
  system,
  ...
}:

{
  options = {
    host.desktop.hyprland.enable = lib.mkEnableOption "Enable if at least one user is using Hyprland";
  };

  config = lib.mkIf config.host.desktop.hyprland.enable {
    fonts.enableDefaultPackages = lib.mkDefault true;
    hardware.graphics.enable = lib.mkDefault true;

    programs.hyprland = {
      enable = config.host.desktop.hyprland.enable;
      package = inputs.hyprland.packages.${system}.hyprland;
      portalPackage = inputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland;
    };

    security.pam.services.hyprlock = { };

    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config = {
        common = {
          default = [
            "hyprland"
            "gtk"
          ];
        };
      };
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
    };
    programs.dconf.enable = true;
    security.polkit.enable = true;

    host.programs.xdg-open.enable = lib.mkDefault true;
  };
}
