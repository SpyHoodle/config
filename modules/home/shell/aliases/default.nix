{ config, lib, ... }:

{
  options = {
    host.shell.aliases.enable = lib.mkEnableOption "Enable generic shell aliases";
  };

  config = lib.mkIf config.host.shell.aliases.enable {
    home.shellAliases = {
      cp = "cp -iv";
      mv = "mv -iv";
      rm = "rm -vI";
      mkd = "mkdir -pv";
      c = "clear";
      e = "exit";

      v = "nvim";
      vi = "nvim";
      ka = "killall";

      ff = "fastfetch";
      hf = "hyfetch";
      tf = "pridefetch -f trans";
      pf = "pfetch";

      grep = "grep --color=auto";
      diff = "diff --color=auto";
    };
  };
}
