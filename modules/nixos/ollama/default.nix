{ config, lib, ... }:

{
  options = {
    host.programs.ollama.enable = lib.mkEnableOption "Enable ollama, local large language models";
  };

  config = lib.mkIf config.host.programs.ollama.enable {
    services.ollama = {
      enable = true;
      # https://github.com/NixOS/nixpkgs/issues/368672
      # acceleration = "rocm";
    };
    services.nextjs-ollama-llm-ui = {
      enable = true;
      port = 1144;
    };
  };
}
