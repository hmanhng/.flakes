{
  programs.hyprland.settings = let
    # Generated using https://gist.github.com/fufexan/e6bcccb7787116b8f9c31160fc8bc543
    accelpoints = "0.5 0.000 0.053 0.115 0.189 0.280 0.391 0.525 0.687 0.880 1.108 1.375 1.684 2.040 2.446 2.905 3.422 4.000 4.643 5.355 6.139";
  in {
    monitor = [
      "eDP-1, 3072x1920@120, 0x0, 2" # thinkbook 14 g6+ 14.5inh 3k 120hz
      "desc:Samsung Electric Company LF24T450F HNAX500305, 1920x1080@75, auto-right, 1" # samsung 24inh
    ];

    "device[cirq1080:00-0488:1054-touchpad]" = {
      accel_profile = "custom ${accelpoints}";
      scroll_points = accelpoints;
      natural_scroll = true;
    };
  };
}
