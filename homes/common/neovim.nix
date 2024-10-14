{ inputs, pkgs, ... }:

{
  home.packages = [
    inputs.editor.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
  programs.zsh.shellAliases.vimdiff = "nvim -d";

  home.sessionVariables.EDITOR = "nvim";
}
