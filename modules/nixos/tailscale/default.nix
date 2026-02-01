{ lib, config, ... }:

{
  options.host.networking.tailscale = {
    enable = lib.mkEnableOption "Enable Tailscale for this system";
    runExitNode = lib.mkOption {
      description = "Enable this system as an exit node on the tailnet";
      default = false;
      type = lib.types.bool;
    };
    server = lib.mkOption {
      description = "Set where your control plane server is";
      default = "controlplane.tailscale.com";
      type = lib.types.str;
    };
    authKeyFile = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Path to key file for tailscale authentication";
    };
  };

  config = lib.mkIf config.host.networking.tailscale.enable {
    services.tailscale = {
      enable = true;
      useRoutingFeatures = if config.host.networking.tailscale.runExitNode then "both" else "client";
      authKeyFile = lib.mkIf (config.host.networking.tailscale.authKeyFile != null) config.host.networking.tailscale.authKeyFile;
      extraUpFlags = [
        "--login-server=https://${config.host.networking.tailscale.server}"
        "--accept-routes"
        "--ssh"
      ]
      ++ (if config.host.networking.tailscale.runExitNode then [ "--advertise-exit-node" ] else [ ]);
    };

    systemd.services.tailscaled.environment.TS_NO_LOGS_NO_SUPPORT = lib.mkIf (
      config.host.networking.tailscale.server != "controlplane.tailscale.com"
    ) "true";
  };
}
