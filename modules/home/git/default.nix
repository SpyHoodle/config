{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    host.git.enable = lib.mkEnableOption "Enable git and recommended settings";
    host.git.gpg.enable = lib.mkEnableOption "Enable GPG signing for git commits";
    host.git.gpg.key = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "The GPG key to use for signing git commits";
    };
    host.git.userName = lib.mkOption {
      type = lib.types.str;
      description = "The name to use for git commits";
    };
    host.git.userEmail = lib.mkOption {
      type = lib.types.str;
      description = "The email to use for git commits";
    };
  };

  config = lib.mkIf config.host.git.enable {
    programs.git = {
      enable = true;
      lfs.enable = true;

      settings = {
        user.name = config.host.git.userName;
        user.email = config.host.git.userEmail;

        alias = {
          pushall = "!git remote | xargs -L1 git push --all";
          graph = "log --graph --oneline --decorate";
          unstage = "reset HEAD --";
          co = "checkout";
          br = "branch";
          ci = "commit";
          st = "status";
          ps = "push";
        };

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

      signing = lib.mkIf config.host.git.gpg.enable {
        key = config.host.git.gpg.key;
        signByDefault = true;
        signer = "${pkgs.gnupg}/bin/gpg";
      };
    };

    home.packages = with pkgs; [ gh ];
  };
}
