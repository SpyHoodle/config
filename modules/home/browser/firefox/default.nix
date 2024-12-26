{ lib, config, ... }:

{
  options = {
    host.browser.firefox.enable = lib.mkEnableOption {
      description = "Enable Firefox with settings";
      default = true;
    };
    host.browser.firefox.defaultBrowser = lib.mkEnableOption {
      description = "Set Firefox as the default browser";
      default = true;
    };
  };

  config = lib.mkIf config.host.browser.firefox.enable {
    programs.firefox = {
      enable = true;
      # TODO: Add firefox settings
      # settings = {
      #   "browser.uidensity" = 1;
      #   "webgl.disabled" = false;
      #   "privacy.resistFingerprinting" = false;
      # };
    };

    xdg.mimeApps = lib.mkIf config.host.browser.firefox.defaultBrowser {
      enable = true;
      defaultApplications = {
        "application/pdf" = [ "firefox.desktop" ];
        "text/html" = [ "firefox.desktop" ];
        "default-web-browser" = [ "firefox.desktop" ];
        "x-scheme-handler/http" = [ "firefox.desktop" ];
        "x-scheme-handler/https" = [ "firefox.desktop" ];
        "x-scheme-handler/about" = [ "firefox.desktop" ];
        "x-scheme-handler/unknown" = [ "firefox.desktop" ];
      };
    };

    home.sessionVariables.BROWSER = lib.mkIf config.host.browser.firefox.defaultBrowser "firefox";
  };
}
