#!/usr/bin/env bash

set -euo pipefail
 
PROFILE="${1:-}"

# The built-in laptop display
INTERNAL="eDP-1"

usage() {
    echo "Usage: $0 <profile>"
    echo "Profiles:"
    echo "  docked    - Enable all external monitors to the left of the laptop display"
    echo "  undocked  - Disable all external monitors, use laptop screen only"
    exit 1
}

# Retrieve all connected monitors except the internal display
get_external_monitors() {
    xrandr --query \
        | grep " connected" \
        | awk '{print $1}' \
        | grep -v "^${INTERNAL}$"
}

set_docked_profile() {
    mapfile -t EXTERNALS < <(get_external_monitors)
 
    if [[ ${#EXTERNALS[@]} -eq 0 ]]; then
        echo "No external monitors detected. Falling back to undocked profile."
        xrandr --output "$INTERNAL" --auto --primary
        exit 0
    fi
 
    echo "External monitors detected: ${EXTERNALS[*]}"
    echo "Applying docked profile..."
 
    CMD="xrandr --output $INTERNAL --auto"
 
    # The last external monitor will be made primary
    LAST_EXTERNAL="${EXTERNALS[-1]}"
 
    for MONITOR in "${EXTERNALS[@]}"; do
        if [[ "$MONITOR" == "$LAST_EXTERNAL" ]]; then
            CMD+=" --output $MONITOR --auto --primary --left-of $INTERNAL"
        else
            CMD+=" --output $MONITOR --auto --left-of $INTERNAL"
        fi
    done
 
    echo "Running: $CMD"
    eval "$CMD"
    echo "Done. $LAST_EXTERNAL is now the primary display."
}

set_undocked_profile() {
    mapfile -t EXTERNALS < <(get_external_monitors)
 
    echo "Applying undocked profile..."
 
    CMD="xrandr --output $INTERNAL --auto --primary"
 
    for MONITOR in "${EXTERNALS[@]}"; do
        CMD+=" --output $MONITOR --off"
    done
 
    echo "Running: $CMD"
    eval "$CMD"
    echo "Done. $INTERNAL is now the only active display."
}

if [[ -z "$PROFILE" ]]; then
    echo "Error: No profile specified." >&2
    usage
fi
 
case "$PROFILE" in
    docked)   
        set_docked_profile 
        ;;
    undocked) 
        set_undocked_profile 
        ;;
   *)
        echo "Error: Unknown profile '$PROFILE'." >&2
        usage
        ;;
esac  
