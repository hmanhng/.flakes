{ pkgs, inputs, ... }:
{
  programs.zed-editor = {
    enable = true;
    package = inputs.zed.packages.${pkgs.stdenv.hostPlatform.system}.default;
    extraPackages = [ pkgs.nixd ];
    extensions = [
      "aura-theme"
      "one-dark-ocean"
      "charmed-icons"
      "git-firefly"
      "nix"
    ];
    userSettings = {
      format_on_save = "off";
      autosave.after_delay.milliseconds = 1000;
      vim_mode = true;
      theme = "Aura Dark";
      icon_theme = "Warm Charmed Icons";
      agent_buffer_font_size = 18.0;
      buffer_font_family = "DankMono Nerd Font";
      buffer_font_size = 18;
      ui_font_family = ".ZedMono";
      ui_font_size = 18;
      base_keymap = "VSCode";

      title_bar = {
        show_onboarding_banner = false;
        show_project_items = true;
        show_branch_name = true;
        show_user_menu = false;
      };
      tab_bar = {
        show = false;
      };
      toolbar = {
        quick_actions = false;
      };
      status_bar = {
        "experimental.show" = false;
      };
      project_panel = {
        dock = "right";
        default_width = 400;
        hide_root = true;
        auto_fold_dirs = false;
        starts_open = false;
        git_status = false;
        sticky_scroll = false;
        scrollbar = {
          show = "never";
        };
        indent_guides = {
          show = "never";
        };
      };
      outline_panel = {
        default_width = 300;
        indent_guides = {
          show = "never";
        };
      };
      file_finder = {
        modal_max_width = "large";
      };
      scrollbar = {
        show = "never";
      };
      gutter = {
        min_line_number_digits = 0;
        folds = false;
        runnables = false;
      };
      indent_guides = {
        enabled = false;
      };
      cursor_blink = false;
      seed_search_query_from_cursor = "never";
      current_line_highlight = "none";
      show_whitespaces = "none";
      close_on_file_delete = true;
      restore_on_startup = "launchpad";
      relative_line_numbers = "enabled";

      theme_overrides = {
        "Aura Dark" = {
          "border.variant" = "#15141C";
          border = "#15141C";
          "title_bar.background" = "#15141C";
          "panel.background" = "#15141C";
          "panel.focused_border" = "#4E466E";
          players = [
            {
              cursor = "#BD9DFF";
            }
          ];
          syntax = {
            comment = {
              font_style = "italic";
            };
            "comment.doc" = {
              font_style = "italic";
            };
          };
        };
      };

      session = {
        trust_all_worktrees = true;
      };
      languages = {
        Nix = {
          language_servers = [
            "nixd"
            "!nil"
          ];
          formatter = {
            external = {
              command = "nixfmt";
              arguments = [
                "--quiet"
                "--"
              ];
            };
          };
        };
      };
    };
  };
}
