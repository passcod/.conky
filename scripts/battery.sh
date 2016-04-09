#!/bin/zsh

battery_permil() {
  source /sys/class/power_supply/BAT1/uevent
  now=$POWER_SUPPLY_CHARGE_NOW
  full=$POWER_SUPPLY_CHARGE_FULL
  hundi=$(dc -e "3k $full $now r/1000*p")
  echo $hundi | cut -d. -f1
}

battery_state() {
  source /sys/class/power_supply/BAT1/uevent
  echo $POWER_SUPPLY_STATUS
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
