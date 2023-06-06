#!/usr/bin/env bash
echo "Move container to selected workspace:"
. /home/owner/.scripts/sway-list-windows.sh

readc selected_workspace
# \e is escape sequence for escape key. dollar sign in front of quotes for sequence to be interpreted.
if [ "$selected_workspace" != $'\e' ]; then
  # first move for the floating foot terminal (this script) and another move for the actual target window to move
  swaymsg move container to workspace $selected_workspace
  swaymsg move container to workspace $selected_workspace
fi
