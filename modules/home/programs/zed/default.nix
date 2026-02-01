{ lib, ... }:

{
  imports = [
    (lib.mkRenamedOptionModule [ "host" "programs" "zed" "enable" ] [ "host" "editor" "zed" "enable" ])
    (lib.mkRenamedOptionModule [ "host" "programs" "zed" "defaultEditor" ] [ "host" "editor" "zed" "defaultEditor" ])
  ];
}
