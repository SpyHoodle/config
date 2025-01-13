{
  lib,
  pkgs,
  config,
  ...
}:

{
  options = {
    host.programs.ssh.enable = lib.mkEnableOption "Enable nix openssh instead of macOS openssh";
  };

  config = lib.mkIf config.host.programs.shell.zsh.enable {
    environment.systemPackages = with pkgs; [
      openssh
    ];
  };
}
