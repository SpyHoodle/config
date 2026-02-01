{
  inputs,
  system,
  lib,
  config,
  ...
}:

{
  options = {
    host.editor.neovim.enable = lib.mkEnableOption "Enable Neovim, a highly configurable text editor";
    host.editor.neovim.defaultEditor = lib.mkEnableOption "Set Neovim as the default editor";
  };

  config = lib.mkIf config.host.editor.neovim.enable {
    home.packages = [ inputs.editor.packages.${system}.default ];
    home.shellAliases.vimdiff = "nvim -d";
    home.sessionVariables = lib.mkIf config.host.editor.neovim.defaultEditor {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };
}
