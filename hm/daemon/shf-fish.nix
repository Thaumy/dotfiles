{ pkgs, ... }:
let
  shf-fish = pkgs.writeScriptBin "shf-fish" ''
    #!${pkgs.dash}/bin/dash

    set -e

    OLD_HISTORY="$HOME/.local/share/fish/fish_history"
    NEW_HISTORY="/tmp/shf-fish-$(date +%s)"

    shf \
      --shell fish \
      --pred-rev \
      --history-path "$OLD_HISTORY" >"$NEW_HISTORY"

    cp "$NEW_HISTORY" "$OLD_HISTORY"

    rm "$NEW_HISTORY"
  '';
in
{
  systemd.user.services.shf-fish = {
    Service = {
      Type = "oneshot";
      ExecStart = "${shf-fish}/bin/shf-fish";
    };
  };

  systemd.user.timers.shf-fish = {
    Timer = {
      OnCalendar = "daily";
      Persistent = true;
    };
    Install.WantedBy = [ "timers.target" ];
  };
}
