#!/usr/bin/env bash

set -euo pipefail
 
PROFILE="${1:-}"
 
usage() {
    echo "Usage: $0 <profile>"
    echo "Profiles:"
    echo "  docked    - Enable external monitor DP-12 as primary (left of eDP-1)"
    echo "  undocked  - Disable external monitor, use laptop screen only"
    exit 1
}
 
if [[ -z "$PROFILE" ]]; then
    echo "Error: No profile specified." >&2
    usage
fi
 
case "$PROFILE" in
    docked)
        echo "Applying docked profile..."
        xrandr --output eDP-1 --auto --output DP-12 --primary --auto --left-of eDP-1
        echo "Done. DP-12 is now the primary display."
        ;;
    undocked)
        echo "Applying undocked profile..."
        xrandr --output eDP-1 --auto --primary --output DP-12 --off
        echo "Done. eDP-1 is now the only active display."
        ;;
    *)
        echo "Error: Unknown profile '$PROFILE'." >&2
        usage
        ;;
esac  
