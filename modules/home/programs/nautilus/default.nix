{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    host.programs.nautilus.enable = lib.mkEnableOption "Enable Nautilus, a GNOME file manager";
  };

  config = lib.mkIf config.host.programs.nautilus.enable {
    home.packages = with pkgs; [
      nautilus
      # Support for mounting remote filesystems
      gvfs
    ];

    # Nautilus dconf settings
    dconf.settings = {
      "org/gnome/nautilus/preferences" = {
        default-folder-viewer = "list-view";
        search-filter-time-type = "last_modified";
        show-hidden-files = true;
      };
      "org/gnome/nautilus/list-view" = {
        default-zoom-level = "small";
        use-tree-view = true;
      };
      "org/gnome/nautilus/icon-view" = {
        default-zoom-level = "medium";
      };
      "org/gtk/gtk4/settings/file-chooser" = {
        show-hidden = true;
        sort-directories-first = true;
      };
    };

    # Set as default file manager
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
      };
    };
  };
}
