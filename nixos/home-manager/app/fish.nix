{ config, pkgs, ... }:

{

  programs.fish = {

    enable = true;

    shellAliases = {
      ls = "exa";
      du = "dust";
      ps = "procs";
      cat = "bat";
    };

    shellInit = ''
      export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
    '';

    interactiveShellInit = ''
      # configure atuin
      #atuin init fish | source

      # color scheme
      set -U fish_color_normal 767676 #-575f66
      set -U fish_color_command 87ff00
      set -U fish_color_quote 767676
      set -U fish_color_redirection afd7d7
      set -U fish_color_end afd7d7
      set -U fish_color_error ff5f5f
      set -U fish_color_param ffffff
      set -U fish_color_comment 5f8700
      set -U fish_color_match f07171
      set -U fish_color_selection --background=f89595
      set -U fish_color_search_match --background=353535
      set -U fish_color_history_current --bold
      set -U fish_color_operator afd7d7
      set -U fish_color_escape 4cbf99
      set -U fish_color_valid_path --underline
      set -U fish_color_autosuggestion 8b8b8b #-8a9199
      set -U fish_color_user 12478b
      set -U fish_color_host 12478b
      set -U fish_color_cwd 399ee6
      set -U fish_color_cwd_root ff5f5f
      set -U fish_color_cancel --reverse
      set -U fish_color_option 
      set -U fish_color_keyword 
      set -U fish_color_host_remote 
      # ...
      set -U fish_pager_color_background 
      set -U fish_pager_color_prefix 131518
      set -U fish_pager_color_progress brwhite --background=6790c5
      set -U fish_pager_color_completion ffffff
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
