{pkgs}:
pkgs.writeShellScriptBin "tmux-sessionizer" ''
  if [[ $# -eq 1 ]]; then
      selected=$1
  else
      selected=$(echo -e "$(find ~/.config/awesome ~/.config/nvim ~/flake -maxdepth 0 -type d)\n$(find ~/Documents/notes ~/Documents/Projects ~/Documents/random ~/Downloads/ -mindepth 1 -maxdepth 1 -type d)" | fzf)
  fi

  if [[ -z $selected ]]; then
      exit 0
  fi

  selected_name=$(basename "$selected" | tr . _)
  tmux_running=$(pgrep tmux)

  if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
      tmux new-session -s $selected_name -c $selected
      exit 0
  fi

  if ! tmux has-session -t=$selected_name 2>/dev/null; then
      tmux new-session -ds $selected_name -c $selected
  fi

  if [[ -n $TMUX ]]; then
    tmux switch-client -t $selected_name
    exit 0
  fi

  # Attach if outside of Tmux
  tmux attach -t $selected_name
''
