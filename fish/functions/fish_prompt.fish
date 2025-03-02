function fish_prompt
  set -l last_pipestatus $pipestatus # save the return status of the previous command
  set -lx __fish_last_status $status # export for __fish_print_pipestatus.

  set -l status_color (set_color $fish_color_status)
  set -l statusb_color (set_color --bold $fish_color_status)
  set -l pipestatus_string (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)

  printf '%s┌╴' (set_color brwhite)

  set -l git_branch (command git branch 2>/dev/null | rg '\* (.+)' -r '$1')
  if [ "$git_branch" != '' ]
    printf '%s%s ' (set_color bryellow) $git_branch
  end

  if functions -q fish_is_root_user; and fish_is_root_user
    printf '%s%s%s%s %s%s %s' \
      (set_color brred) $USER '@' (prompt_hostname) \
      (set_color $fish_color_cwd) (prompt_pwd -d 50 -D 1) $pipestatus_string
  else
    printf '%s%s%s%s %s%s %s' \
      (set_color brblue) $USER '@' (prompt_hostname) \
      (set_color $fish_color_cwd) (prompt_pwd -d 50 -D 1) $pipestatus_string
  end

  printf '\n%s└╴%s' (set_color brwhite) (set_color normal)
end

