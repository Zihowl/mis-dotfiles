#!/bin/sh

SOURCE="alsa_input.pci-0000_00_1f.3.analog-stereo"

# Get Mute Status
MUTE=$(pactl get-source-mute $SOURCE 2>/dev/null)

if [ "$MUTE" = "Mute: yes" ]; then
    echo '{"text": "Muted", "alt": "muted", "class": "muted", "percentage": 0}'
else
    # Get Volume
    VOL=$(pactl get-source-volume $SOURCE 2>/dev/null | grep -oP '\d+%' | head -1 | tr -d '%')
    if [ -z "$VOL" ]; then VOL=0; fi
    echo "{\"text\": \"$VOL%\", \"alt\": \"unmuted\", \"class\": \"unmuted\", \"percentage\": $VOL}"
fi
