{
  config,
  pkgs,
  ...
}: let
  cfg = config.programs.git;
  key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIE7SZ125Onjw0TNCng0bxbXmsIZuVZIVjNrPOH886uY hmanhng@laptop";
in {
  programs.gh.enable = true;

  # enable scrolling in git diff
  home.sessionVariables.DELTA_PAGER = "less -R";

  programs.git = {
    enable = true;

    delta = {
      enable = true;
      options.dark = true;
      options = {
        decorations = {
          file-decoration-style = "none";
          file-modified-label = "modified:";
          file-style = "bold blue ul";
          hunk-header-style = "omit";
          hunk-header-decoration-style = "";
          # minus-style = "#d91e46";
          # minus-emph-style = "normal";
          # plus-style = "#9feb98";
          # plus-emph-style = "normal";
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

    extraConfig = {
      diff.colorMoved = "default";
      merge.conflictstyle = "diff3";
    };

    aliases = let
      log = "log --show-notes='*' --abbrev-commit --pretty=format:'%Cred%h %Cgreen(%aD)%Creset -%C(bold red)%d%Creset %s %C(bold blue)<%an>% %Creset' --graph";
    in {
      a = "add --patch"; # make it a habit to consciosly add hunks
      ad = "add";

      b = "branch";
      ba = "branch -a"; # list remote branches
      bd = "branch --delete";
      bdd = "branch -D";

      c = "commit";
      ca = "commit --amend";
      cm = "commit --message";

      co = "checkout";
      cb = "checkout -b";
      pc = "checkout --patch";

      cl = "clone";

      d = "diff";
      ds = "diff --staged";

      h = "show";
      h1 = "show HEAD^";
      h2 = "show HEAD^^";
      h3 = "show HEAD^^^";
      h4 = "show HEAD^^^^";
      h5 = "show HEAD^^^^^";

      p = "push";
      pf = "push --force-with-lease";

      pl = "pull";

      l = log;
      lp = "${log} --patch";
      la = "${log} --all";

      r = "rebase";
      ra = "rebase --abort";
      rc = "rebase --continue";
      ri = "rebase --interactive";

      rs = "reset";
      rsh = "reset --hard";
      rss = "reset --soft";

      s = "status --short --branch";
      ss = "status";

      st = "stash";
      stc = "stash clear";
      sth = "stash show --patch";
      stl = "stash list";
      stp = "stash pop";

      forgor = "commit --amend --no-edit";
      oops = "checkout --";
    };

    ignores = ["*~" "*.swp" "*result*" ".direnv" "node_modules"];

    signing = {
      key = "${config.home.homeDirectory}/.ssh/id_ed25519";
      signByDefault = true;
      format = "ssh";
    };

    extraConfig = {
      gpg.ssh.allowedSignersFile = config.home.homeDirectory + "/" + config.xdg.configFile."git/allowed_signers".target;

      pull.rebase = true;
    };

    userEmail = "hmanhng@icloud.com";
    userName = "Hmanhng";
  };

  xdg.configFile."git/allowed_signers".text = ''
    ${cfg.userEmail} namespaces="git" ${key}
  '';

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
