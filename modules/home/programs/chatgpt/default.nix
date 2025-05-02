{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    host.programs.chromium.chatgpt.enable = lib.mkEnableOption "Enable ChatGPT chromium app";
  };

  config = lib.mkIf config.host.programs.spotify.enable {
    xdg.desktopEntries.chatgpt = {
      name = "ChatGPT";
      exec = "${pkgs.chromium}/bin/chromium --app=https://chatgpt.com";
      terminal = false;
      type = "Application";
      categories = [ "Application" "Network" "WebBrowser" ];
    };
  };
}
