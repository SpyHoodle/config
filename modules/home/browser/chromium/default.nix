{ lib, config, pkgs, ... }:

{
  options = {
    host.browser.chromium.enable = lib.mkEnableOption "Enable Chromium browser with extensions";
    host.browser.chromium.defaultBrowser = lib.mkEnableOption "Set Chromium as the default browser";
  };

  config = lib.mkIf config.host.browser.chromium.enable {


    programs.chromium = {
      enable = true;
      package = pkgs.chromium.override { enableWideVine = true; };
      extensions = [
        # Dark Reader
        { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; }
        # uBlock Origin
        { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; }
        # I still don't care about cookies
        { id = "edibdbjcniadpccecjdfdjjppcpchdlm"; }
        # Reddit Enhancement Suite
        { id = "kbmfpngjjgdllneeigpgjifpgocmfgmb"; }
        # Return Youtube Dislike
        { id = "gebbhagfogifgggkldgodflihgfeippi"; }
      ];
    };

    xdg.mimeApps = lib.mkIf config.host.browser.chromium.defaultBrowser {
      enable = true;
      defaultApplications = {
        # "application/pdf"               = [ "chromium-browser.desktop" ];
        "text/html" = [ "chromium-browser.desktop" ];
        "default-web-browser" = [ "chromium-browser.desktop" ];
        "x-scheme-handler/http" = [ "chromium-browser.desktop" ];
        "x-scheme-handler/https" = [ "chromium-browser.desktop" ];
        "x-scheme-handler/about" = [ "chromium-browser.desktop" ];
        "x-scheme-handler/unknown" = [ "chromium-browser.desktop" ];
      };
    };

    home.sessionVariables.BROWSER = lib.mkIf config.host.browser.chromium.defaultBrowser "chromium";
  };
}
