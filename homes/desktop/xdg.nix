{ pkgs, ... }:

{
  home.packages = with pkgs; [
    xdg-utils
    xdg-user-dirs
  ];
  
  home.sessionVariables = {
    BROWSER = "librewolf";
    TERMINAL = "alacritty";
  };

  xdg = {
    enable = true;
    userDirs.enable = true;
    desktopEntries = {
      "browser" = {
        name = "Web Browser";
        type = "Application";
        exec = "${pkgs.librewolf}/bin/librewolf %f";
      };
      "image" = {
        name = "Image Viewer";
        type = "Application";
        exec = "${pkgs.nsxiv}/bin/nsxiv -a %f";
      };
      "text" = {
        name = "Text Editor";
        type = "Application";
        exec = "${pkgs.alacritty}/bin/alacritty -e ${pkgs.neovim}/bin/nvim %u";
      };
      "pdf" = {
        name = "PDF Reader";
        type = "Application";
        exec = "${pkgs.zathura}/bin/zathura %u";
      };
    };
    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = "pdf.desktop";
        "x-scheme-handler/http" = "browser.desktop";
        "x-scheme-handler/https" = "browser.desktop";
        "image/png" = "image.desktop";
        "image/jpeg" = "image.desktop";
        "image/jpg" = "image.desktop";
        "image/gif" = "image.desktop";
        "video/mp4" = "mpv.desktop";
        "text/plain" = "text.desktop";
        "text/html" = "browser.desktop";
      };
    };
  };
}
