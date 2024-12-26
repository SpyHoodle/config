{
  lib,
  config,
  pkgs,
  ...
}:

{
  options = {
    host.browser.tor-browser.enable = lib.mkEnableOption "Enable Tor Browser, a privacy-focused web browser";
  };

  config = lib.mkIf config.host.browser.tor-browser.enable {
    home.packages = with pkgs; [ tor-browser ];
  };
}
