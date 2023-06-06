#!/usr/bin/env bash
setterm -linewrap off

readc() { # arg: <variable-name>
  if [ -t 0 ]; then
    # if stdin is a tty device, put it out of icanon, set min and
    # time to sane value, but don't otherwise touch other input or
    # or local settings (echo, isig, icrnl...). Take a backup of the
    # previous settings beforehand.
    saved_tty_settings=$(stty -g)
    stty -icanon min 1 time 0
  fi
  eval "$1="
  while
    # read one byte, using a work around for the fact that command
    # substitution strips the last character.
    c=$(dd bs=1 count=1 2> /dev/null; echo .)
    c=${c%.}

    # break out of the loop on empty input (eof) or if a full character
    # has been accumulated in the output variable (using "wc -m" to count
    # the number of characters).
    [ -n "$c" ] &&
      eval "$1=\${$1}"'$c
        [ "$(($(printf %s "${'"$1"'}" | wc -m)))" -eq 0 ]'; do
    continue
  done
  if [ -t 0 ]; then
    # restore settings saved earlier if stdin is a tty device.
    stty "$saved_tty_settings"
  fi
}

jq_filter='
    # descend to workspace or scratchpad
    .nodes[].nodes[]
    # save workspace name as .w
    | {"w": .name} + (
      if (.nodes|length) > 0 then # workspace
        [recurse(.nodes[])]
      else # scratchpad
        []
      end
      + .floating_nodes
      | .[]
      # select nodes with no children (windows)
      | select(.nodes==[])
    )
    | [
      "\(.w)",
      # get app name (or window class if xwayland)
      "\(if .app_id == null then .window_properties.class else .app_id end)",
      "\(.name)"
    ] | @tsv
'

swaymsg -t get_tree | jq -r "$jq_filter" | rg -v "^.\slauncher\sfoot$"
