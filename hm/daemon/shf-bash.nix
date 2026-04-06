{ pkgs, ... }:
let
  shf-bash = pkgs.writeShellScriptBin "shf-bash" ''
    #!/usr/bin/env dash

    set -e

    OLD_HISTORY="$HOME/.bash_history"
    NEW_HISTORY="/tmp/shf-bash-$(date +%s)"

    shf \
      --shell bash \
      --pred-rev \
      --history-path "$OLD_HISTORY" >"$NEW_HISTORY"

    cp "$NEW_HISTORY" "$OLD_HISTORY"

    rm "$NEW_HISTORY"
  '';
in
{
  systemd.user.services.shf-bash = {
    Service = {
      Type = "oneshot";
      ExecStart = "${shf-bash}/bin/shf-bash";
    };
  };

  systemd.user.timers.shf-bash = {
    Timer = {
      OnCalendar = "daily";
      Persistent = true;
    };
    Install.WantedBy = [ "timers.target" ];
  };
}
