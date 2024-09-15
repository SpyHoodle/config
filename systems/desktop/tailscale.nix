{
  clicks.networking.tailscale = {
    enable = true;
  };
  services.tailscale.extraUpFlags = [ "--hostname=desktop" ];
}
