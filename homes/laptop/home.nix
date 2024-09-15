{ username, lib, ... }:

{
  programs.home-manager.enable = true;
  home = {
    inherit username;
    homeDirectory = lib.mkForce "/Users/${username}";
    stateVersion = "24.11";
  };
}
