{ config, lib, ... }:

{
  options = {
    host.doas.enable = lib.mkEnableOption "Enable doas, a more secure alternative to sudo";
  };

  config = lib.mkIf config.host.doas.enable {
    security.sudo.enable = false;
    security.doas = {
      enable = true;
      extraRules = [
        {
          users = [ "${config.host.user.name}" ];
          keepEnv = true;
          persist = true;
        }
      ];
    };
  };
}
