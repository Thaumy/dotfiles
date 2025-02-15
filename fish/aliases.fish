alias q "exit"
alias g "command git"
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

alias hmb "home-manager build --cores 6"
alias hms "home-manager switch"
alias nrb "sudo nixos-rebuild build  --cores 6"
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

function pr
    set path "$(command git rev-parse --show-toplevel 2> /dev/null)"
    if test $path != ''; cd $path; return; end

    set path "$(cargo locate-project --workspace --message-format plain 2> /dev/null)"
    if test $path != ''; cd "$(dirname $path)"; return; end

    echo 'project root not found'
end
