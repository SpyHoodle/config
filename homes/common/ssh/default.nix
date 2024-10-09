{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      jet = {
        hostname = "jet.echo.clicks.domains";
        user = "maddie";
      };
      desktop = {
        hostname = "desktop.maddie.clicks.domains";
        user = "maddie";
      };
    };
  };
}
