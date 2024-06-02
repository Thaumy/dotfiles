function fish_user_key_bindings
    # remove presets
    bind -e --preset \cA # beginning-of-line
    bind -e --preset \cE # end-of-line
    bind -e --preset \cF # forward-char
    bind -e --preset \cB # backward-char
    bind -e --preset \eu # upcase-word
    bind -e --preset \v # kill-line
    bind -e --preset \cU # backward-kill-line

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
    bind \eh beginning-of-buffer # C-h
    bind \el end-of-buffer # C-l
    bind \e\x7F kill-whole-line # M-Bs
end
