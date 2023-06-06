#!/usr/bin/env bash
kill $(swaymsg -t get_tree | jq -r '.nodes[].nodes[].floating_nodes[] | (if .app_id == "launcher" then .pid|tostring else "" end)')
