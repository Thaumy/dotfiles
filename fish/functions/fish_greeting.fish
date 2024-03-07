function fish_greeting

    # rand string
    set randstr $(string sub --length 4 $(uuidgen))
    set_color white
    echo "  $randstr"

end

