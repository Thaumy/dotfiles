alias q "exit"
alias g "git"
alias c "cargo"
alias l "eza -l --git -g --time-style '+%y-%m-%d %H:%M' -a --smart-group --group-directories-first"
alias hm "home-manager"
alias ls "eza --no-permissions --no-filesize --no-user --no-time --group-directories-first"
alias se "sudo -E"
alias to "command touch"
alias md "command mkdir"
alias du "dust"
alias ps "procs"
alias cat "bat --style numbers"
alias svs "sudo -E systemctl-tui"
alias sctl "systemctl"

alias nrb "sudo nixos-rebuild boot"
alias nrs "sudo nixos-rebuild switch"

alias dk "docker"
alias lzdk "lazydocker"

function lc
    cd "$(command lf -print-last-dir $argv)"
end

function rm
    printf "please use %srr%s instead, %srm%s is considered unsafe!\n" (set_color green) (set_color normal) (set_color yellow) (set_color normal)
end

function sed
    printf "please use %ssd%s instead.\n" (set_color green) (set_color normal)
end

function grep
    printf "please use %srg%s instead.\n" (set_color green) (set_color normal)
end

function find
    printf "please use %sfd%s instead.\n" (set_color green) (set_color normal)
end

function touch
    printf "please use %sto%s instead.\n" (set_color green) (set_color normal)
end

function mkdir
    printf "please use %smd%s instead.\n" (set_color green) (set_color normal)
end
