{default, ...}: {
  home = {
    sessionVariables = {
      TERMINAL = "kitty";
    };
  };
  programs = {
    kitty = {
      enable = true;
      environment = {};
      keybindings = {};
      theme = "Catppuccin-Mocha";
      # font.name = "JetBrainsMono Nerd Font";
      font.name = default.terminal.font;
      font.size = default.terminal.size;
      settings = {
        bold_font = "auto";
        italic_font = "auto";
        bold_italic_font = "auto";
        # window_padding_width = "5 10";
        mouse_hide_wait = 2;
        cursor_shape = "underline";
        shell_integration = "no-cursor";
        cursor = "none";
        url_color = "#0087bd";
        url_style = "dotted";
        #Close the terminal =  without confirmation;
        confirm_os_window_close = 0;
        background_opacity = toString default.terminal.opacity;
        dynamic_background_opacity = true;
        tab_bar_min_tabs = 2;
        tab_bar_edge = "bottom";
        tab_bar_style = "powerline";
        tab_powerline_style = "slanted";
        tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";
      };
    };
  };
}
