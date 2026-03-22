#!/bin/sh
pkill -9 dunst
dunst -conf ~/.cache/wal/dunstrc &

WAL_COLOR=$(sed -n '2p' ~/.cache/wal/colors)

R=$(printf "%d" 0x${WAL_COLOR:1:2})
G=$(printf "%d" 0x${WAL_COLOR:3:2})
B=$(printf "%d" 0x${WAL_COLOR:5:2})

DIFF_RG=$(( R - G < 0 ? G - R : R - G ))
DIFF_RB=$(( R - B < 0 ? B - R : R - B ))
DIFF_GB=$(( G - B < 0 ? B - G : G - B ))

# If all channels close together = grey/bluegrey
if [ $DIFF_RG -lt 40 ] && [ $DIFF_RB -lt 40 ] && [ $DIFF_GB -lt 40 ]; then
    if [ $B -gt $R ]; then FOLDER_COLOR="bluegrey"
    else FOLDER_COLOR="grey"; fi
elif [ $R -gt $G ] && [ $R -gt $B ]; then
    if [ $G -gt 100 ]; then FOLDER_COLOR="orange"
    else FOLDER_COLOR="red"; fi
elif [ $G -gt $R ] && [ $G -gt $B ]; then
    if [ $B -gt 80 ]; then FOLDER_COLOR="teal"
    else FOLDER_COLOR="green"; fi
elif [ $B -gt $R ] && [ $B -gt $G ]; then
    if [ $R -gt 80 ]; then FOLDER_COLOR="violet"
    elif [ $G -gt 80 ]; then FOLDER_COLOR="cyan"
    else FOLDER_COLOR="blue"; fi
else
    FOLDER_COLOR="grey"
fi

sudo papirus-folders -C "$FOLDER_COLOR" --theme Papirus-Dark
