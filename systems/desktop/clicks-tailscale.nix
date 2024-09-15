# SPDX-FileCopyrightText: 2024 Clicks Codes
#
# SPDX-License-Identifier: GPL-3.0-only

{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.clicks.networking.tailscale;
in
{
  options.clicks.networking.tailscale = {
    enable = lib.mkEnableOption "Enable tailscale for this system";
    runExitNode.enable = lib.mkOption {
      description = "Enable this system as an exit node on the tailnet";
      default = true;
      type = lib.types.bool;
    };
    server = lib.mkOption {
      description = "Set where your control plane server is";
      default = "clicks.domains";
      example = "controlplane.tailscale.com";
    };
    authKeyFile = lib.mkOption {
      type = lib.types.str;
      description = "Path to key file for tailscale";
    };
  };

  config = lib.mkIf cfg.enable {
    services.tailscale = {
      enable = true;
      useRoutingFeatures = if cfg.runExitNode.enable then "both" else "client";
      extraUpFlags = [
        "--login-server=https://${cfg.server}"
        "--accept-routes"
      ] ++ (if cfg.runExitNode.enable then [ "--advertise-exit-node" ] else [ ]);
    };

    systemd.services.tailscaled.environment.TS_NO_LOGS_NO_SUPPORT = lib.mkIf (
      cfg.server != "controlplane.tailscale.com"
    ) "true";
  };
}
