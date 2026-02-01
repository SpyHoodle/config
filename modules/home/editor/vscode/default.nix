{
  config,
  lib,
  ...
}:

{
  options = {
    host.editor.vscode.enable = lib.mkEnableOption "Enable VSCode, a code editor";
    host.editor.vscode.defaultEditor = lib.mkEnableOption "Set VSCode as the default editor";
  };

  config = lib.mkIf config.host.editor.vscode.enable {
    programs.vscode.enable = true;

    home.sessionVariables = lib.mkIf config.host.editor.vscode.defaultEditor {
      EDITOR = "code --wait";
      VISUAL = "code --wait";
    };
  };
}
