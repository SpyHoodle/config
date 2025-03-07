{
  config,
  lib,
  ...
}:

{
  options = {
    host.systemd.nixOOMKiller.enable = lib.mkEnableOption "Enable agressive nix-daemon out of memory killing";
  };

  config = lib.mkIf config.host.systemd.nixOOMKiller.enable {
    systemd = {
      # Create a separate slice for nix-daemon that is
      # memory-managed by the userspace systemd-oomd killer
      slices."nix-daemon".sliceConfig = {
        ManagedOOMMemoryPressure = "kill";
        ManagedOOMMemoryPressureLimit = "50%";
      };
      services."nix-daemon".serviceConfig.Slice = "nix-daemon.slice";

      # If a kernel-level OOM event does occur anyway,
      # strongly prefer killing nix-daemon child processes
      services."nix-daemon".serviceConfig.OOMScoreAdjust = 1000;
    };
  };
}
