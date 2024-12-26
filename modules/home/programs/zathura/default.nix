{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    host.programs.zathura.enable = lib.mkEnableOption "Enable zathura, a document viewer";
  };

  config = lib.mkIf config.host.programs.zathura.enable {
    programs.zathura.enable = true;

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = [
          "org.pwmt.zathura-pdf-mupdf.desktop"
          "org.pwmt.zathura.desktop"
        ];
      };
    };
  };
}
