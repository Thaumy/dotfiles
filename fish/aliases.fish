alias g "command git"
alias c cargo
alias n "tmux new-window -ad"
alias nvp "tmux new-window -ad && vp"
alias hm home-manager
alias to "command touch"
alias md "command mkdir"
alias du dust
alias ps procs
alias mx tmux
alias cat "bat --style numbers"
alias clr "clear && tmux clear-history"
alias svs "sudo systemctl-tui"
alias sctl systemctl
alias hibernate "systemctl hibernate"

alias q exit
alias qa "tmux kill-session"

alias hmb "home-manager build --flake path:(realpath $HOME/cfg) --cores 6 --no-out-link"
alias hms "home-manager switch --flake path:(realpath $HOME/cfg)"
alias nrb "nixos-rebuild build --flake path:(realpath $HOME/cfg) --cores 6 && command rm -f result"
alias nrs "sudo nixos-rebuild switch --flake path:(realpath $HOME/cfg)"
alias nfu "nix flake update"

alias dk docker
alias lzdk lazydocker

functions -e ll
alias l "eza --no-permissions --no-filesize --no-user --no-time --group-directories-first"
alias ls "eza -l --git -g --time-style '+%y-%m-%d %H:%M' --smart-group --group-directories-first"
alias la "ls -a"
alias lt "ls --tree"
alias lta "la --tree"

function ti
    if set -q argv[1]
        if test "$argv[1]" = -s
            if set -q argv[2]
                # set tmux session name
                tmux rename-session "$argv[2]"
            else
                # clear tmux session name
                tmux rename-session "$(tmux display-message -p '#{session_id}' | string replace '$' '')"
                echo "󰜴 session name cleared"
            end
        else
            # clear fish title
            set -g SHELL_TITLE "$argv[1]"
        end
    else
        # clear fish title
        set -e SHELL_TITLE
        echo "󰜴 shell title cleared"
    end
    return 0
end

function lc
    cd "$(command lf -print-last-dir $argv)"
end

function rm
    printf "please use %srr%s instead, %srm%s is considered unsafe!\n" (set_color green) (set_color normal) (set_color yellow) (set_color normal)
end

function pr
    set path "$(command git rev-parse --show-toplevel 2> /dev/null)"
    if test $path != ''
        cd $path
        return
    end

    set path "$(cargo locate-project --workspace --message-format plain 2> /dev/null)"
    if test $path != ''
        cd "$(dirname $path)"
        return
    end

    echo 'project root not found'
end
