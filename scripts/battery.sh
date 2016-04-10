#!/bin/zsh

battery=0
battery_file=/sys/class/power_supply/BAT$battery/uevent

battery_var() {
  grep "POWER_SUPPLY_$1" "$battery_file" | cut -d\= -f2
}

battery_permil() {
  now=$(battery_var CHARGE_NOW)
  full=$(battery_var CHARGE_FULL)
  hundi=$(dc -e "3k $full $now r/1000*p")
  echo $hundi | cut -d. -f1
}

battery_state() {
  echo $(battery_var STATUS)
}


PERMIL=$(battery_permil)

ICON="%"
if [ $PERMIL -ge 750 ]; then
  COLOR="#[fg=green]"
elif battery_state | grep -vq Discharging; then
  COLOR="#[fg=green]"
  ICON="ϟ"
elif [ $PERMIL -ge 250 ]; then
  COLOR="#[fg=yellow]"
else
  COLOR="#[fg=red]"
fi


[ -z "$PERMIL" ] && exit

if echo "$1" | grep -q "integer"; then
  dc -e "${PERMIL} 10/p"
elif echo "$1" | grep -q "float"; then
  dc -e "1k ${PERMIL} 10/p"
elif echo "$1" | grep -q "state"; then
    battery_state
else
  echo "${COLOR}$(dc -e "1k $PERMIL 10/p")${ICON}"
fi
