{ config, lib, pkgs, ... }:

{
  options = {
    host.audio.pipewire.enable = lib.mkEnableOption "Enable the pipewire daemon";
  };

  config = lib.mkIf config.host.audio.pipewire.enable {
    services.pulseaudio = {
      enable = false;
      package = pkgs.pulseaudioFull;
    };
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
