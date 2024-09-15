{
  home = {
    shellAliases = {
      cp = "cp -iv";
      mv = "mv -iv";
      rm = "rm -vI";
      mkd = "mkdir -pv";
      c = "clear";
      e = "exit";

      v = "nvim";
      vi = "nvim";
      ka = "killall";
      nf = "neofetch";
      tf = "pridefetch -f trans";
      pf = "pfetch";
      i = "inertia";

      mac-system-update = "nix flake update $NIXFILES && darwin-rebuild switch --flake $NIXFILES";

      btop = "btop --utf-force";
      grep = "grep --color=auto";
      diff = "diff --color=auto";
    };

    sessionVariables = {
      LANG = "en_GB.UTF-8";
      LC_ALL = "en_GB.UTF-8";

      NIXFILES = "$HOME/Documents/Code/NixFiles";
    };

    sessionPath = [
      "$HOME/.local/bin"
    ];
  };
}
