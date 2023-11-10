{
  config,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      cava
      mpc-cli
      # youtube-music
      # netease-cloud-music-gtk
      # go-musicfox
    ];
    file.".config/cava/config".source = ./cava_config;
    file.".config/cava/config1".source = ./cava_config1;
  };
  programs = {
    ncmpcpp = {
      enable = true;
      # mpdMusicDir = "~/Music";
      settings = {
        user_interface = "alternative";
      };
      bindings = [
        {
          key = "j";
          command = "scroll_down";
        }
        {
          key = "k";
          command = "scroll_up";
        }
        {
          key = "J";
          command = ["select_item" "scroll_down"];
        }
        {
          key = "K";
          command = ["select_item" "scroll_up"];
        }
      ];
    };
  };

  services = {
    mpd = {
      enable = true;
      musicDirectory = "~/Music";
      extraConfig = ''
        audio_output {
                type            "pipewire"
                name            "PipeWire Sound Server"
        }
      '';
    };
  };
}
