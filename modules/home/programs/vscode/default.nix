{ lib, ... }:

{
  imports = [
    (lib.mkRenamedOptionModule [ "host" "programs" "vscode" "enable" ] [ "host" "editor" "vscode" "enable" ])
    (lib.mkRenamedOptionModule [ "host" "programs" "vscode" "defaultEditor" ] [ "host" "editor" "vscode" "defaultEditor" ])
  ];
}

