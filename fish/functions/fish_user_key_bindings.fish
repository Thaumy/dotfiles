# use `fish_key_reader` to find out key sequence

function fish_user_key_bindings
    # remove presets
    bind -e --preset \cA # beginning-of-line
    bind -e --preset \cD # exit
    bind -e --preset \cE # end-of-line
    bind -e --preset \cF # forward-char
    bind -e --preset \cB # backward-char
    bind -e --preset \eu # upcase-word
    bind -e --preset \v # kill-line
    bind -e --preset \cU # backward-kill-line
    bind -e --preset \ee # edit command in editor

    # C-h
    bind \b \
        backward-char \
        backward-char \
        backward-char \
        backward-char \
        backward-char \
        backward-char \
        backward-char \
        backward-char
    # C-l
    bind \f \
        forward-char \
        forward-char \
        forward-char \
        forward-char \
        forward-char \
        forward-char \
        forward-char \
        forward-char
    bind \ea beginning-of-buffer # M-a
    bind \ed end-of-buffer # M-d
    bind \e\x7F kill-whole-line # M-Bs
    bind \eh prevd-or-backward-word # M-h
    bind \el nextd-or-forward-word # M-l
    bind \ei edit_command_buffer # edit command in editor
end
