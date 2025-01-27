{ lib, config, ... }:

{
  options.host.networking.tailscale = {
    enable = lib.mkEnableOption "Enable tailscale for this system";
    runExitNode.enable = lib.mkOption {
      description = "Enable this system as an exit node on the tailnet";
      default = true;
      type = lib.types.bool;
    };
    server = lib.mkOption {
      description = "Set where your control plane server is";
      default = "controlplane.tailscale.com";
    };
    authKeyFile = lib.mkOption {
      type = lib.types.str;
      description = "Path to key file for tailscale";
    };
  };

  config = lib.mkIf config.host.networking.tailscale.enable {
    services.tailscale = {
      enable = true;
      useRoutingFeatures = if config.host.networking.tailscale.runExitNode.enable then "both" else "client";
      extraUpFlags = [
        "--login-server=https://${config.host.networking.tailscale.server}"
        "--accept-routes"
      ] ++ (if config.host.networking.tailscale.runExitNode.enable then [ "--advertise-exit-node" ] else [ ]);
    };

    systemd.services.tailscaled.environment.TS_NO_LOGS_NO_SUPPORT = lib.mkIf (
      config.host.networking.tailscale.server != "controlplane.tailscale.com"
    ) "true";
  };
}
