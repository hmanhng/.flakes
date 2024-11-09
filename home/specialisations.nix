{
  theme = {
    wallpaper = let
      url = "https://github.com/hmanhng/wallpapers/blob/master/12.png?raw=true";
      sha256 = "1knd31cl7w145z14ny7hrxmq9awd2isn7h9r55z69w2hbik7i6iz";
      ext = "png";
    in
      builtins.fetchurl {
        name = "wallpaper-${sha256}.${ext}";
        inherit url sha256;
      };
  };
}
