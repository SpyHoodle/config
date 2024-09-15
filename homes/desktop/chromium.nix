{
  programs.chromium = {
    enable = true;
    commandLineArgs = [
      "--enable-logging=stderr"
      "--ignore-gpu-blocklist"
    ];
    extensions = [
      # Dark Reader
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; }
      # uBlock Origin
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; }
      # I still don't care about cookies
      { id = "edibdbjcniadpccecjdfdjjppcpchdlm"; }
      # NoScript
      { id = "doojmbjmlfjjnbmnoijecmcbfeoakpjm"; }
      # Reddit Enhancement Suite
      { id = "kbmfpngjjgdllneeigpgjifpgocmfgmb"; }
      # Old Reddit Redirect
      { id = "dneaehbmnbhcippjikoajpoabadpodje"; }
      # Return Youtube Dislike
      { id = "gebbhagfogifgggkldgodflihgfeippi"; }
      # Vimium
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; }
    ];
  };
}
