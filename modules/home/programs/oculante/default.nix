{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    host.programs.oculante.enable = lib.mkEnableOption "Enable Oculante, an image viewer";
  };

  config = lib.mkIf config.host.programs.oculante.enable {
    home.packages = with pkgs; [ oculante ];

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "image/*" = [ "oculante.desktop" ];
        "image/png" = [ "oculante.desktop" ];
        "image/jpg" = [ "oculante.desktop" ];
        "image/jpeg" = [ "oculante.desktop" ];
        "image/qoi" = [ "oculante.desktop" ];
      };
    };
  };
}
