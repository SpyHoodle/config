{ config, lib, ... }:

{
  options = {
    host.audio.pipewire.enable = lib.mkEnableOption "Enable the pipewire daemon";
  };

  config = lib.mkIf config.host.audio.pipewire.enable {
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
  };
}
