#!/usr/bin/env bash
# ~/.config/waybar/scripts/powermenu.sh

ENTRIES=(
  "⏻  Shutdown"
  "  Reboot"
  "  Suspend"
  "  Lock"
  "  Logout"
)

CHOICE=$(printf '%s\n' "${ENTRIES[@]}" | rofi -dmenu -p "Power menu" -i -lines 5)

case "$CHOICE" in
  "⏻  Shutdown") systemctl poweroff ;;
  "  Reboot")   systemctl reboot ;;
  "  Suspend")  systemctl suspend ;;
  "  Lock")     hyprlock ;;
  "  Logout")   hyprctl dispatch exit ;;
esac