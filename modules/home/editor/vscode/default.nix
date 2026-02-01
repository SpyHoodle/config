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

  config =
    let
      defaultEditors = [
        config.host.editor.zed.defaultEditor
        config.host.editor.vscode.defaultEditor
        config.host.editor.neovim.defaultEditor
      ];
      defaultEditorCount = builtins.length (lib.filter (value: value) defaultEditors);
    in
    lib.mkMerge [
      {
        assertions = [
          {
            assertion = defaultEditorCount <= 1;
            message = "Only one default editor can be enabled (Zed, VSCode, or Neovim).";
          }
        ];
      }
      (lib.mkIf config.host.editor.vscode.enable {
        programs.vscode.enable = true;

        home.sessionVariables = lib.mkIf config.host.editor.vscode.defaultEditor {
          EDITOR = "code --wait";
          VISUAL = "code --wait";
        };
      })
    ];
}
