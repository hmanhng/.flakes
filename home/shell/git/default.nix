{
  programs.git = {
    enable = true;
    userName = "Hmanhng";
    userEmail = "hmanhng@icloud.com";
    extraConfig = {
      url = {
        "git@github.com:hmanhng/" = {
          insteadOf = "https://github.com/hmanhng/";
        };
      };
    };
    /* delta.enable = true; */
    difftastic.enable = true;
  };
  programs.gitui = {
    enable = true;
    keyConfig = ''
      exit: Some(( code: Char('c'), modifiers: ( bits: 2,),)),
      quit: Some(( code: Char('q'), modifiers: ( bits: 0,),)),
      exit_popup: Some(( code: Esc, modifiers: ( bits: 0,),)),
    '';
    theme = ''
      (
        selected_tab: Reset,
        command_fg: Rgb(198, 208, 245),
        selection_bg: Rgb(98, 104, 128),
        selection_fg: Rgb(198, 208, 245),
        cmdbar_bg: Rgb(41, 44, 60),
        cmdbar_extra_lines_bg: Rgb(41, 44, 60),
        disabled_fg: Rgb(131, 139, 167),
        diff_line_add: Rgb(166, 209, 137),
        diff_line_delete: Rgb(231, 130, 132),
        diff_file_added: Rgb(229, 200, 144),
        diff_file_removed: Rgb(234, 153, 156),
        diff_file_moved: Rgb(202, 158, 230),
        diff_file_modified: Rgb(239, 159, 118),
        commit_hash: Rgb(186, 187, 241),
        commit_time: Rgb(181, 191, 226),
        commit_author: Rgb(133, 193, 220),
        danger_fg: Rgb(231, 130, 132),
        push_gauge_bg: Rgb(140, 170, 238),
        push_gauge_fg: Rgb(48, 52, 70),
        tag_fg: Rgb(242, 213, 207),
        branch_fg: Rgb(129, 200, 190)
      )
    '';
  };
}
