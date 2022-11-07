popman() {
  if [ ! -z "$BUFFER" ]; then
    CMD=$(echo "$BUFFER" | awk '{ print $1; }')
    tmux popup -EE -h 35 -w 130 man "$CMD"
  fi
}
