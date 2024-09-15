{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      jet = {
        identityFile = "~/.ssh/id_ed25519_sk";
        hostname = "jet.echo.clicks.domains";
        user = "maddie";
      };
      clicks = {
        identityFile = "~/.ssh/clickscodes";
        hostname = "git.clicks.codes";
        port = 29418;
        user = "maddie";
      };
    };
  };
}
