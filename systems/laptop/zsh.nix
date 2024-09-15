{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableSyntaxHighlighting = true;
    enableCompletion = true;
  };
  environment.loginShell = pkgs.zsh;
}
