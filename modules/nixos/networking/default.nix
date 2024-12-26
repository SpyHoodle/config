{ lib, config, ... }:

{
  options = {
    host.networking.enable = lib.mkEnableOption "Enable networking management";
    host.networking.hostName = lib.mkOption {
      type = lib.types.str;
      default = "nixos";
      description = "The hostname of the system";
    };
    host.networking.useDHCP = lib.mkOption {
      type = lib.types.bool;
      description = "Whether to use DHCP to configure the network";
      default = true;
    };
    host.networking.wireless.enable = lib.mkEnableOption {
      description = "Whether to enable wireless networking";
      default = false;
    };
    host.networking.wireless.networks = lib.mkOption {
      type = lib.types.attrsOf (
        lib.types.submodule {
          options = {
            psk = lib.mkOption {
              type = lib.types.str;
            };
          };
        }
      );
      default = { };
      description = "Wireless networks to connect to";
    };
    host.networking.firewall.enable = lib.mkEnableOption "Whether to enable the firewall";
    host.networking.firewall.allowedTCPPorts = lib.mkOption {
      type = lib.types.listOf lib.types.int;
      default = [ ];
      example = [
        22
        80
        443
      ];
      description = "TCP ports to allow";
    };
  };

  config = lib.mkIf config.host.networking.enable {
    networking.hostName = config.host.networking.hostName;
    networking.useDHCP = config.host.networking.useDHCP;

    networking.wireless = lib.mkIf config.host.networking.wireless.enable {
      enable = true;
      userControlled.enable = true;
      networks = config.host.networking.wireless.networks;
    };

    networking.firewall = lib.mkIf config.host.networking.firewall.enable {
      enable = true;
      allowedTCPPorts = config.host.networking.firewall.allowedTCPPorts;
    };
  };
}
