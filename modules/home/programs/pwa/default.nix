{ config, lib, pkgs, ... }:

{
  options = {
    host.programs.chromium.chatgpt.enable              = lib.mkEnableOption "Enable ChatGPT chromium app";
    host.programs.chromium.icloud.enable               = lib.mkEnableOption "Enable iCloud chromium app";
    host.programs.chromium.icloud-drive.enable         = lib.mkEnableOption "Enable iCloud Drive chromium app";
    host.programs.chromium.icloud-notes.enable         = lib.mkEnableOption "Enable iCloud Notes chromium app";
    host.programs.chromium.photopea.enable             = lib.mkEnableOption "Enable Photopea chromium app";
    host.programs.chromium.github-copilot.enable       = lib.mkEnableOption "Enable GitHub Copilot chromium app";
    host.programs.chromium.search-nixos.enable         = lib.mkEnableOption "Enable search.nixos.org chromium app";
    host.programs.chromium.search-nixos-options.enable = lib.mkEnableOption "Enable search.nixos.org/options chromium app";
    host.programs.chromium.ollama.enable               = lib.mkEnableOption "Enable Ollama (localhost:1144) chromium app";
  };

  config = {
    xdg.desktopEntries.chatgpt = lib.mkIf config.host.programs.chromium.chatgpt.enable {
      name       = "ChatGPT";
      exec       = "${pkgs.chromium}/bin/chromium --app=https://chatgpt.com";
      terminal   = false;
      type       = "Application";
      categories = [ "Application" "Network" "WebBrowser" ];
    };

    xdg.desktopEntries.icloud = lib.mkIf config.host.programs.chromium.icloud.enable {
      name       = "iCloud";
      exec       = "${pkgs.chromium}/bin/chromium --app=https://icloud.com";
      terminal   = false;
      type       = "Application";
      categories = [ "Application" "Network" "WebBrowser" ];
    };

    xdg.desktopEntries.icloud-drive = lib.mkIf config.host.programs.chromium.icloud-drive.enable {
      name       = "iCloud Drive";
      exec       = "${pkgs.chromium}/bin/chromium --app=https://www.icloud.com/iclouddrive";
      terminal   = false;
      type       = "Application";
      categories = [ "Application" "Network" "WebBrowser" ];
    };

    xdg.desktopEntries.icloud-notes = lib.mkIf config.host.programs.chromium.icloud-notes.enable {
      name       = "iCloud Notes";
      exec       = "${pkgs.chromium}/bin/chromium --app=https://www.icloud.com/notes";
      terminal   = false;
      type       = "Application";
      categories = [ "Application" "Network" "WebBrowser" ];
    };

    xdg.desktopEntries.photopea = lib.mkIf config.host.programs.chromium.photopea.enable {
      name       = "Photopea";
      exec       = "${pkgs.chromium}/bin/chromium --app=https://www.photopea.com";
      terminal   = false;
      type       = "Application";
      categories = [ "Application" "Network" "WebBrowser" ];
    };

    xdg.desktopEntries.github-copilot = lib.mkIf config.host.programs.chromium.github-copilot.enable {
      name       = "GitHub Copilot";
      exec       = "${pkgs.chromium}/bin/chromium --app=https://github.com/copilot";
      terminal   = false;
      type       = "Application";
      categories = [ "Application" "Network" "WebBrowser" ];
    };

    xdg.desktopEntries.search-nixos = lib.mkIf config.host.programs.chromium.search-nixos.enable {
      name       = "NixOS Search";
      exec       = "${pkgs.chromium}/bin/chromium --app=https://search.nixos.org";
      terminal   = false;
      type       = "Application";
      categories = [ "Application" "Development" ];
    };

    xdg.desktopEntries.search-nixos-options = lib.mkIf config.host.programs.chromium.search-nixos-options.enable {
      name       = "NixOS Options Search";
      exec       = "${pkgs.chromium}/bin/chromium --app=https://search.nixos.org/options";
      terminal   = false;
      type       = "Application";
      categories = [ "Application" "Development" ];
    };

    xdg.desktopEntries.ollama = lib.mkIf config.host.programs.chromium.ollama.enable {
      name       = "Ollama";
      exec       = "${pkgs.chromium}/bin/chromium --app=http://localhost:1144";
      terminal   = false;
      type       = "Application";
      categories = [ "Application" "Network" "WebBrowser" ];
    };
  };
}
