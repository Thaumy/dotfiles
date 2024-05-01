function polish_pwd
  echo $argv[1] | sed -e "s;$HOME;~;"
end

function fish_prompt
  # save the return status of the previous command
  set -l last_pipestatus $pipestatus
  set -lx __fish_last_status $status # export for __fish_print_pipestatus.

  if functions -q fish_is_root_user; and fish_is_root_user
    printf '%s@%s %s%s%s# ' \
      $USER (prompt_hostname) \
      (set -q fish_color_cwd_root
      and set_color $fish_color_cwd_root
      or set_color $fish_color_cwd) \
      (prompt_pwd) (set_color normal)
  else
    set -l status_color (set_color $fish_color_status)
    set -l statusb_color (set_color --bold $fish_color_status)
    set -l pipestatus_string (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)

    printf '%s┌' (set_color brwhite)

    printf '%s%s %s%s%s%s %s%s%s%s ' \
      (set_color bryellow) (fish_git_prompt) \
      (set_color brblue) $USER '@' (prompt_hostname) \
      (set_color $fish_color_cwd) $(polish_pwd $PWD) ' ' $pipestatus_string

    printf '\n'
    printf '%s└ ' (set_color brwhite)

    printf '%s' (set_color normal)
  end
end

