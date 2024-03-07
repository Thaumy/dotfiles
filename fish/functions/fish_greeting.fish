function fish_greeting

    # rand string
    set randstr $(string sub --length 4 $(uuidgen))
    set_color white
    echo "  $randstr"

    # history filter
    set raw_history_path "$HOME/.local/share/fish/fish_history"
    set processed_history_path "/tmp/shf_fish_history-$(date +%s)"
    sh-history-filter \
      --shell fish \
      --pred-rev \
      --history-path $raw_history_path > $processed_history_path
    and cp $processed_history_path $raw_history_path

end

