{ pkgs, ... }:

{
  programs.slock.enable = true;
  security.wrappers.slock.source = "${pkgs.slock.out}/bin/slock";
}
