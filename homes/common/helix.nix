{
  programs.helix = {
    enable = true;
    settings = {
      theme = "onedark";
      keys.normal = {
        space.space = "file_picker";
        space.w = ":w";
        space.q = ":q";
      };
    };
  };
}
