{
  lib,
  pkgs,
  config,
  ...
}:

{
  options = {
    host.programs.shell.zsh.enable = lib.mkEnableOption "Enable zsh as the default shell";
  };

  config = lib.mkIf config.host.programs.shell.zsh.enable {
    programs.zsh = {
      enable = true;
      enableSyntaxHighlighting = true;
      enableCompletion = true;
    };
    environment.systemPath = [ "/opt/homebrew/bin" ];
  };
}
