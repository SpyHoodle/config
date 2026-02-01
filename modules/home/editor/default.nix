# Shared editor module with assertion logic to prevent multiple default editors
{ config, lib, ... }:

let
  defaultEditors = [
    config.host.editor.zed.defaultEditor
    config.host.editor.vscode.defaultEditor
    config.host.editor.neovim.defaultEditor
  ];
  defaultEditorCount = builtins.length (lib.filter (value: value) defaultEditors);
in
{
  config = {
    assertions = [
      {
        assertion = defaultEditorCount <= 1;
        message = "Only one default editor can be enabled. Currently enabled: ${
          lib.concatStringsSep ", " (
            lib.optional config.host.editor.zed.defaultEditor "Zed"
            ++ lib.optional config.host.editor.vscode.defaultEditor "VSCode"
            ++ lib.optional config.host.editor.neovim.defaultEditor "Neovim"
          )
        }";
      }
    ];
  };
}
