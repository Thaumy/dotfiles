{ config, pkgs, ... }:

{

  programs.bash = {
    enable = true;
    initExtra = ''
      # history filter
      declare raw_history_path="$HOME/.bash_history"
      declare processed_history_path="/tmp/shf_bash_history-$(date +%s)"
      sh-history-filter \
        --shell bash \
        --pred-rev \
        --history-path $raw_history_path > $processed_history_path \
      && cp $processed_history_path $raw_history_path
    '';
  };

}
