# color scheme
set fish_color_normal white
set fish_color_command brgreen
set fish_color_quote white
set fish_color_redirection brcyan
set fish_color_end afd7d7
set fish_color_error red
set fish_color_param white
set fish_color_comment 5f8700
set fish_color_match f07171
set fish_color_selection --background=f89595
set fish_color_search_match --background=353535
set fish_color_history_current --bold
set fish_color_operator afd7d7
set fish_color_escape 4cbf99
set fish_color_valid_path --underline
set fish_color_autosuggestion 8b8b8b
set fish_color_user 12478b
set fish_color_host 12478b
set fish_color_cwd brcyan
set fish_color_cwd_root ff5f5f
set fish_color_cancel --reverse
set fish_color_option
set fish_color_keyword
set fish_color_host_remote
# ...
set fish_pager_color_background
set fish_pager_color_prefix grey
set fish_pager_color_progress brwhite --background=6790c5
set fish_pager_color_completion brwhite #-ffffff
set fish_pager_color_description 8b8b8b
# ...
set fish_pager_color_selected_prefix ffffff
set fish_pager_color_selected_completion ffffff
set fish_pager_color_selected_description ffffff
set fish_pager_color_selected_background --background=39b4c0
# ...
set fish_pager_color_secondary_prefix
set fish_pager_color_secondary_background
set fish_pager_color_secondary_completion
set fish_pager_color_secondary_description

any-nix-shell fish --info-right | source
