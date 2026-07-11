if [ -z "$XDG_CONFIG_HOME" ]; then
  echo "\$XDG_CONFIG_HOME not found"
  exit 1
fi

cfg_dir="$XDG_CONFIG_HOME/tmux-ws"

if [ "$#" -eq 0 ]; then
  for file in "$cfg_dir"/*.sh; do
    if [ -f "$file" ]; then
      basename "$file" .sh
    fi
  done
  exit 0
fi

export SESSION_NAME="$1"
profile_script="$cfg_dir/$SESSION_NAME.sh"

if [ ! -f "$profile_script" ]; then
  echo "profile not found"
  exit 1
fi

echo "[ws] $SESSION_NAME"

if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
  echo "workspace exists"
  exit 1
fi
tmux new-session -d -s "$SESSION_NAME" -c "$HOME"

dash "$profile_script"
