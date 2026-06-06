function fish_title
    if set -q SHELL_TITLE
        echo "$SHELL_TITLE"
        return
    end

    set -l cmd (status current-command)
    if test "$cmd" = fish
        set cmd
    end

    sh-title $cmd
end
