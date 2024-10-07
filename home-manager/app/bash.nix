{ ... }: {
  programs.bash = {
    enable = true;
    initExtra = ''
      # history filter
      declare old_history="$HOME/.bash_history"
      declare new_history="/tmp/bak_bash_history_$(date +%s)"
      sh-history-filter \
        --shell bash \
        --pred-rev \
        --history-path $old_history > $new_history \
      && cp $new_history $old_history \
      && rm $new_history
    '';
  };
}
