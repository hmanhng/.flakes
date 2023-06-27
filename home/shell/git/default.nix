{
  programs.git = {
    enable = true;
    userName = "Hmanhng";
    userEmail = "hmanhng@icloud.com";
    aliases = {
      aa = "add -A";
      br = "branch";
      co = "checkout";
      cm = "commit";
      cmm = "commit -m";
      cmam = "commit -am";
      cam = "commit --amend -m";
      lg = "!sh -c 'if [ $0 = sh ]; then git log --oneline; else git log --oneline -$0; fi'";
	    lgg = "log --oneline --graph";
      rs = "reset";
      rss = "reset --soft";
      rsh = "reset --hard";
      st = "status";
    };
    extraConfig = {
      url = {
        "git@github.com:hmanhng/" = {
          insteadOf = "https://github.com/hmanhng/";
        };
      };
    };
    delta = {
      enable = true;
      options = {
        decorations = {
          file-decoration-style = "none";
          file-modified-label = "modified:";
          file-style = "bold blue ul";
          hunk-header-style = "omit";
          hunk-header-decoration-style = "";
          /* minus-style = "#d91e46"; */
          /* minus-emph-style = "normal"; */
          /* plus-style = "#9feb98"; */
          /* plus-emph-style = "normal"; */
          line-numbers = true;
          line-numbers-left-format = "{nm}⋮";
          line-numbers-minus-style = "#d91e46";
          line-numbers-right-format = " {np} ";
          line-numbers-plus-style = "#9feb98";
        };
        features = "decorations";
        whitespace-error-style = "22 reverse";
      };
    };
    difftastic = { enable = false; display = "inline"; };
    diff-so-fancy = { enable = false; };
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
