{
  # Stop systemd from hanging for ages
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';
}
