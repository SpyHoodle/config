{ lib, config, ... }:

{
  options = {
    host.browser.chromium.enable = lib.mkEnableOption {
      description = "Enable Chromium browser with extensions";
      default = true;
    };
    host.browser.chromium.defaultBrowser = lib.mkEnableOption {
      description = "Set Chromium as the default browser";
      default = false;
    };
  };

  config = lib.mkIf config.host.browser.chromium.enable {
    programs.chromium = {
      enable = true;
      extensions = [
        # Dark Reader
        { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; }
        # uBlock Origin
        { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; }
        # I still don't care about cookies
        { id = "edibdbjcniadpccecjdfdjjppcpchdlm"; }
        # Reddit Enhancement Suite
        { id = "kbmfpngjjgdllneeigpgjifpgocmfgmb"; }
        # Old Reddit Redirect
        { id = "dneaehbmnbhcippjikoajpoabadpodje"; }
        # Return Youtube Dislike
        { id = "gebbhagfogifgggkldgodflihgfeippi"; }
        # Vimium
        { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; }
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
