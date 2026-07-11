sn=$SESSION_NAME
win_id=0

w() {
  win_id=$((win_id + 1))
  dir="$1"

  echo "[win] $sn:$win_id $dir"

  tmux new-window -d -t "$sn:$win_id" -c "$dir"
}

t() {
  local title="$1"

  echo "[tit] $sn:$win_id $title"

  tmux send-keys -t "$sn:$win_id" "ti '$title'" Enter
}

r() {
  local cmd="$1"

  echo "[run] $sn:$win_id $cmd"

  tmux send-keys -t "$sn:$win_id" "$cmd" Enter
}

clr() {
  echo "[clr] $sn:$win_id"

  tmux send-keys -t "$sn:$win_id" 'history clear-session; and clear' Enter
}

default() {
  echo "[default] $sn:$win_id"

  tmux select-window -t "$sn:$win_id"
}

attach() {
  echo "[attach] $sn"

  tmux switch-client -t "$sn"
}
