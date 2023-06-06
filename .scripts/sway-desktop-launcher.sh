#!/usr/bin/env bash
setterm -linewrap off

paths_spaced="/home/owner/.local/share/applications/ /nix/var/nix/profiles/per-user/owner/profile/share/applications/ /run/current-system/sw/share/applications/ /var/lib/flatpak/exports/share/applications/ /usr/share/applications/"
name=$(fd -e desktop . $paths_spaced | sd ".+/(.+)\.desktop" "\$1" | sort -u | fzf --prompt='Launch app: ')

IFS=" "
for path in $paths_spaced; do
  swaymsg exec dex "$path$name.desktop"
  # to avoid executing in all 3 paths, we can stop at first success or keep the index number from fzf return or for each fzf entry, we can have a prepended id
done

sleep 0.1
