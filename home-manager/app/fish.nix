{ ... }: {
  programs.fish = {
    enable = true;

    shellAliases = {
      l = "eza -l --git -g --time-style '+%m-%d %H:%M' -a --smart-group --group-directories-first";
      ls = "eza -l --no-permissions --no-filesize --no-user --no-time --group-directories-first";
      du = "dust";
      ps = "procs";
      cat = "bat --style numbers";
      q = "exit";
    };

    shellInit = ''
      export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
    '';

    interactiveShellInit = ''
      # color scheme
      set -U fish_color_normal white
      set -U fish_color_command brgreen
      set -U fish_color_quote white
      set -U fish_color_redirection brcyan
      set -U fish_color_end afd7d7
      set -U fish_color_error red
      set -U fish_color_param white
      set -U fish_color_comment 5f8700
      set -U fish_color_match f07171
      set -U fish_color_selection --background=f89595
      set -U fish_color_search_match --background=353535
      set -U fish_color_history_current --bold
      set -U fish_color_operator afd7d7
      set -U fish_color_escape 4cbf99
      set -U fish_color_valid_path --underline
      set -U fish_color_autosuggestion 8b8b8b
      set -U fish_color_user 12478b
      set -U fish_color_host 12478b
      set -U fish_color_cwd brcyan
      set -U fish_color_cwd_root ff5f5f
      set -U fish_color_cancel --reverse
      set -U fish_color_option
      set -U fish_color_keyword
      set -U fish_color_host_remote
      # ...
      set -U fish_pager_color_background
      set -U fish_pager_color_prefix grey
      set -U fish_pager_color_progress brwhite --background=6790c5
      set -U fish_pager_color_completion brwhite #-ffffff
      set -U fish_pager_color_description 8b8b8b
      # ...
      set -U fish_pager_color_selected_prefix ffffff
      set -U fish_pager_color_selected_completion ffffff
      set -U fish_pager_color_selected_description ffffff
      set -U fish_pager_color_selected_background --background=39b4c0
      # ...
      set -U fish_pager_color_secondary_prefix
      set -U fish_pager_color_secondary_background
      set -U fish_pager_color_secondary_completion
      set -U fish_pager_color_secondary_description
    '';
  };
}
