{
  pkgs,
  config,
  ...
}:
{
  programs.yazi = {
    enable = true;
    # package = inputs.yazi.packages.${pkgs.stdenv.hostPlatform.system}.yazi;
    enableFishIntegration = true;
    shellWrapperName = "r";
    settings = {
      mgr = {
        layout = [
          1
          4
          3
        ];
        sort_by = "alphabetical";
        sort_sensitive = true;
        sort_reverse = false;
        sort_dir_first = true;
        linemode = "none";
        show_hidden = false;
        show_symlink = true;
      };

      preview = {
        tab_size = 2;
        max_width = 600;
        max_height = 900;
        cache_dir = config.xdg.cacheHome;
      };
      opener = {
        extract = [
          {
            run = "ouch d -y \"$@\"";
            desc = "Extract here with ouch";
            for = "unix";
          }
        ];
      };
      tasks.image_alloc = 1073741824; # = 1024*1024*1024 = 1024MB
      plugin = {
        prepend_previewers = [
          {
            mime = "application/{*zip,tar,bzip2,7z*,rar,xz,zstd,java-archive}";
            run = "ouch --show-file-icons";
          }
          {
            mime = "{audio,video,image}/*";
            run = "mediainfo";
          }
          {
            mime = "application/subrip";
            run = "mediainfo";
          }
          # Adobe Illustrator, Adobe Photoshop is image/adobe.photoshop, already handled above
          {
            mime = "application/postscript";
            run = "mediainfo";
          }
          {
            name = "*.md";
            run = "piper -- CLICOLOR_FORCE=1 glow -w=$w -s=dark \"$1\"";
          }
        ];
        prepend_preloaders = [
          # Replace magick, image, video with mediainfo
          {
            mime = "{audio,video,image}/*";
            run = "mediainfo";
          }
          {
            mime = "application/subrip";
            run = "mediainfo";
          }
          # Adobe Illustrator, Adobe Photoshop is image/adobe.photoshop, already handled above
          {
            mime = "application/postscript";
            run = "mediainfo";
          }
        ];
      };
    };
    keymap = {
      mgr = { };
    };
    plugins = with pkgs.yaziPlugins; {
      inherit
        ouch
        mediainfo
        piper
        ;
    };
    extraPackages = with pkgs; [
      ouch
      mediainfo
      glow
    ];
  };
}
