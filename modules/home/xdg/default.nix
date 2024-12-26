{ config, lib, ... }:

{
  options = {
    host.xdgCleanup.enable = lib.mkEnableOption {
      description = "Prefer xdg directories where possible";
      default = true;
    };
  };

  config = lib.mkIf config.host.xdgCleanup.enable {
    home = {
      preferXdgDirectories = true;
      sessionVariables = {
        CUDA_CACHE_PATH = "${config.xdg.cacheHome}/nv";
        LESSHISTFILE = "${config.xdg.configHome}/less/history";
        LESSKEY = "${config.xdg.configHome}/less/keys";
        WINEPREFIX = "${config.xdg.dataHome}/wine";
        _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=${config.xdg.configHome}/java";
      };
      shellAliases = {
        wget = "wget --hsts-file='${config.xdg.dataHome}/wget-hsts'";
      };
    };
  };
}
