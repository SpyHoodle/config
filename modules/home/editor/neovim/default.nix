{
  inputs,
  system,
  lib,
  config,
  ...
}:

{
  options = {
    host.editor.neovim.enable = lib.mkEnableOption {
      description = "Enable Neovim, a highly configurable text editor";
      default = true;
    };
    host.editor.neovim.defaultEditor = lib.mkEnableOption {
      default = true;
      description = "Set Neovim as the default editor";
    };
  };

  config = lib.mkIf config.host.editor.neovim.enable {
    home.packages = [ inputs.editor.packages.${system}.default ];
    home.shellAliases.vimdiff = "nvim -d";
    home.sessionVariables.EDITOR = lib.mkIf config.host.editor.neovim.defaultEditor "nvim";
  };
}
