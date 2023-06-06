#!/usr/bin/env bash
echo "Select workspace:"
. /home/owner/.scripts/sway-list-windows.sh

readc selected_workspace
# \e is escape sequence for escape key. dollar sign in front of quotes for sequence to be interpreted.
if [ "$selected_workspace" != $'\e' ]; then
  swaymsg workspace $selected_workspace
fi
