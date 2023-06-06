#!/usr/bin/env bash
new_volume=$(pulsemixer --change-volume -5 --get-volume | sd '^(\d{1,3})\s\d{1,3}$' '$1')
notify-send "Volume: $new_volume%" -h string:x-canonical-private-synchronous:anything
