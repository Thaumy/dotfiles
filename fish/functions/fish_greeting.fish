function fish_greeting
    # time and pid
    echo "$(date +'%H:%M:%S') • $fish_pid"

    # history filter
    set old_history "$HOME/.local/share/fish/fish_history"
    set new_history "/tmp/shf_fish_history-$(date +%s)"
    sh-history-filter \
      --shell fish \
      --pred-rev \
      --history-path $old_history > $new_history
    and cp $new_history $old_history
    and command rm $new_history

end

