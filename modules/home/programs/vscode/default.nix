{
  config,
  lib,
  ...
}:

{
  options = {
    host.programs.vscode.enable = lib.mkEnableOption "Enable VSCode, a code editor";
  };

  config = lib.mkIf config.host.programs.vscode.enable {
    programs.vscode.enable = true;
  };
}

