{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    lfs.enable = true;

    userName = "Maddie H";
    userEmail = "maddie@spyhoodle.me";
    signing = {
      key = "FA50688B9EB6D8AA070C8241C296DE8C9053683F";
      signByDefault = true;
      gpgPath = "${pkgs.gnupg}/bin/gpg";
    };

    aliases = {
      graph = "log --graph --oneline --decorate";
      unstage = "reset HEAD --";
      co = "checkout";
      br = "branch";
      ci = "commit";
      st = "status";
      ps = "push";
    };

    extraConfig = {
      init.defaultBranch = "development";
      pull.rebase = "merges";
      core.sshCommand = "${pkgs.openssh}/bin/ssh";
    };

    ignores = [
      "**/.DS_Store"
      "**/._.DS_Store"
      ".DS_Store"
      "._.DS_Store"
      "**/*.swp"
      "*.swp"
    ];
  };

  home.packages = with pkgs; [
    gh
    git-review
  ];
}
