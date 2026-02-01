{ config, lib, pkgs, ... }:

let
  pwaApps = {
    chatgpt = {
      name = "ChatGPT";
      url = "https://chatgpt.com";
    };
    gemini = {
      name = "Gemini";
      url = "https://gemini.google.com";
    };
    icloud = {
      name = "iCloud";
      url = "https://icloud.com";
    };
    icloud-drive = {
      name = "iCloud Drive";
      url = "https://www.icloud.com/iclouddrive";
    };
    icloud-notes = {
      name = "iCloud Notes";
      url = "https://www.icloud.com/notes";
    };
    photopea = {
      name = "Photopea";
      url = "https://www.photopea.com";
    };
    github-copilot = {
      name = "GitHub Copilot";
      url = "https://github.com/copilot";
    };
    search-nixos = {
      name = "NixOS Search";
      url = "https://search.nixos.org";
      categories = [ "Application" "Development" ];
    };
    search-nixos-options = {
      name = "NixOS Options Search";
      url = "https://search.nixos.org/options";
      categories = [ "Application" "Development" ];
    };
    ollama = {
      name = "Ollama";
      url = "http://localhost:1144";
    };
  };

  mkOption = id: app:
    lib.setAttrByPath
      [ "host" "programs" "chromium" id "enable" ]
      (lib.mkEnableOption "Enable ${app.name} chromium app");

  mkDesktopEntry = app: {
    name = app.name;
    exec = "${pkgs.chromium}/bin/chromium --app=${app.url}";
    terminal = false;
    type = "Application";
    categories = app.categories or [ "Application" "Network" "WebBrowser" ];
  };
in
{
  options = lib.foldl'
    lib.recursiveUpdate
    { }
    (lib.mapAttrsToList mkOption pwaApps);

  config = {
    xdg.desktopEntries = lib.mapAttrs (
      id: app: lib.mkIf config.host.programs.chromium.${id}.enable (mkDesktopEntry app)
    ) pwaApps;
  };
}
