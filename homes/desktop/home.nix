{ username, lib, ... }:

{
  programs.home-manager.enable = true;
  home = {
    inherit username;
    homeDirectory = lib.mkForce "/home/${username}";
    stateVersion = "24.11";
  };
}
