[
  # My build of suckless dwm
  (final: prev: {
    st = prev.st.overrideAttrs (oldAttrs: {
      src = final.fetchFromGitea {
        domain = "git.spyhoodle.me";
        owner = "maddie";
        repo = "st";
        rev = "95838457b677f5dc4397603e6df76df1789c9c36";
        sha256 = "sha256-EuipD68T8I+g1kKHqYy79Iata08Ac0SD24uLXBlM77A=";
      };
      buildInputs = oldAttrs.buildInputs ++ [ final.harfbuzz ];
    });
    ncmpcpp = prev.ncmpcpp.override {
      visualizerSupport = true;
      clockSupport = false;
    };
    nerdfonts = prev.nerdfonts.override {
      fonts = [ "Iosevka" "JetBrainsMono" "Terminus"  ];
    };
    chromium = prev.chromium.override {
      enableWideVine = true;
    };
  })
]
