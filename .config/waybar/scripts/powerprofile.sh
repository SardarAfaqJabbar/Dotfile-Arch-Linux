#!/usr/bin/env bash
# ~/.config/waybar/scripts/powerprofile.sh
# Uses gdbus directly — avoids broken powerprofilesctl Python dependency

PROFILES=("performance" "balanced" "power-saver")
LABELS=("⚡ RAZGON" "⚡ MELANIA" "⚡ ZEN")
CLASSES=("razgon" "melania" "zen")

get_current() {
  gdbus call --system \
    --dest net.hadess.PowerProfiles \
    --object-path /net/hadess/PowerProfiles \
    --method org.freedesktop.DBus.Properties.Get \
    net.hadess.PowerProfiles ActiveProfile \
    2>/dev/null | grep -oP "(?<=')[^']*(?=')"
}

set_profile() {
  gdbus call --system \
    --dest net.hadess.PowerProfiles \
    --object-path /net/hadess/PowerProfiles \
    --method org.freedesktop.DBus.Properties.Set \
    net.hadess.PowerProfiles ActiveProfile \
    "<'$1'>" 2>/dev/null
}

get_current_index() {
  local current
  current=$(get_current)
  for i in "${!PROFILES[@]}"; do
    [[ "${PROFILES[$i]}" == "$current" ]] && echo "$i" && return
  done
  echo "1"
}

case "$1" in
  get)
    idx=$(get_current_index)
    printf '{"text":"%s","class":"%s"}\n' "${LABELS[$idx]}" "${CLASSES[$idx]}"
    ;;
  cycle)
    idx=$(get_current_index)
    next=$(( (idx + 1) % ${#PROFILES[@]} ))
    set_profile "${PROFILES[$next]}"
    kill -42 $(pidof waybar) 2>/dev/null
    ;;
  *)
    echo "Usage: $0 {get|cycle}"
    exit 1
    ;;
esac
