#!/usr/bin/env bash
old_volume=$(pulsemixer --get-volume | sd '^(\d{1,3})\s\d{1,3}$' '$1')

if [ "$old_volume" -lt 100 ]; then
  new_volume=$(pulsemixer --change-volume +5 --get-volume | sd '^(\d{1,3})\s\d{1,3}$' '$1')
  notify-send "Volume: $new_volume%" -h string:x-canonical-private-synchronous:anything
fi
