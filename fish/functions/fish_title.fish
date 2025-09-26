function fish_title
    if set -q SHELL_TITLE
        echo "$SHELL_TITLE"
        return
    end

    # If we're connected via ssh, we print the hostname.
    set -l ssh
    set -q SSH_TTY
    and set ssh "["(prompt_hostname | string sub -l 10 | string collect)"]"
    # An override for the current command is passed as the first parameter.
    # This is used by `fg` to show the true process name, among others.
    if set -q argv[1]
        echo -- $ssh (prompt_pwd -d 50 -D 1) (string sub -l 20 -- $argv[1])
    else
        # Don't print "fish" because it's redundant
        set -l command (status current-command)
        if test "$command" = fish
            set command
        end
        echo -- $ssh (prompt_pwd -d 50 -D 1) (string sub -l 20 -- $command)
    end
end
