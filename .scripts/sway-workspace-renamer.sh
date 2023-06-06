#!/usr/bin/env bash
echo "Rename workspace to: "
. /home/owner/.scripts/sway-list-windows.sh

readc selected_workspace
# \e is escape sequence for escape key. dollar sign in front of quotes for sequence to be interpreted.
if [ "$selected_workspace" != $'\e' ]; then
  swaymsg rename workspace $(swaymsg -t get_workspaces | jq '.[] | select(.focused==true) | .name') to $selected_workspace
fi
