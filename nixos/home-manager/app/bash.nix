{ config, pkgs, ... }:

{

  programs.bash = {
    enable = true;
    initExtra = ''
      declare history_path="$HOME/.bash_history"
      declare history_backup_path='/tmp/shf_bash_history'
      sh-history-filter \
        --shell bash \
        --pred-rev \
        --history-path $history_path > $history_backup_path
      cp $history_backup_path $history_path
    '';
  };

}
