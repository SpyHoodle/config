{ pkgs, ... }:

{
  home.packages = with pkgs; [
    radicle-node
  ];
}
