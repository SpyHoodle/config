{ config, lib, ... }:

{
  options = {
    host.locale.timeZone = lib.mkOption {
      type = lib.types.str;
      default = "Europe/London";
    };
    host.locale.locale = lib.mkOption {
      type = lib.types.str;
      default = "en_GB.UTF-8";
    };
  };

  config = {
    i18n.defaultLocale = config.host.locale.locale;
    time.timeZone = config.host.locale.timeZone;

    i18n.extraLocaleSettings = {
      LC_ADDRESS = config.host.locale.locale;
      LC_IDENTIFICATION = config.host.locale.locale;
      LC_MEASUREMENT = config.host.locale.locale;
      LC_MONETARY = config.host.locale.locale;
      LC_NAME = config.host.locale.locale;
      LC_NUMERIC = config.host.locale.locale;
      LC_PAPER = config.host.locale.locale;
      LC_TELEPHONE = config.host.locale.locale;
      LC_TIME = config.host.locale.locale;
    };
  };
}
