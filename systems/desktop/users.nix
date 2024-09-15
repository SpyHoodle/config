{ pkgs, username, ... }:

{
  users.users.${username} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Madeleine";
    extraGroups = [ "dialout" "plugdev" ];
    openssh.authorizedKeys.keyFiles = [ ../../homes/common/ssh/maddie.pub ];
  };
}
