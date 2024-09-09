source ~/cfg/fish/env.fish
source ~/cfg/fish/color-scheme.fish

alias q "exit"
alias l "eza -l --git -g --time-style '+%y-%m-%d %H:%M' -a --smart-group --group-directories-first"
alias ls "eza --no-permissions --no-filesize --no-user --no-time --group-directories-first"
alias se "sudo -E"
alias du "dust"
alias ps "procs"
alias cat "bat --style numbers"
alias svs "sudo -E systemctl-tui"
alias sctl "systemctl"

alias c-b "cargo b"
alias c-r "cargo r"
alias c-f "cargo fmt"
alias c-a "cargo audit"
alias c-t "cargo nextest run --workspace"
alias c-c "cargo clippy --tests --workspace"

function lc
    cd "$(command lf -print-last-dir $argv)"
end

function rm
    printf "please use %srr%s instead, %srm%s is considered unsafe!\n" (set_color green) (set_color normal) (set_color yellow) (set_color normal)
end

function grep
    printf "please use %srg%s instead.\n" (set_color green) (set_color normal)
end

function find
    printf "please use %sfd%s instead.\n" (set_color green) (set_color normal)
end

any-nix-shell fish --info-right | source
