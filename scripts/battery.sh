#!/usr/bin/env bash

STATUS=$(acpi -b | cut -d ',' -f 1 | cut -d ' ' -f 3 )
PERCENT=$(acpi -b | cut -d ',' -f 2 | tr -d '[:space:]')
TOTAL=${PERCENT::-1}
CHARGING_ICON=""


if [ $TOTAL -gt "80" ]; then
  BATTERY_ICON=""
elif [ $TOTAL -gt "60" ]; then
  BATTERY_ICON=""
elif [ $TOTAL -gt "40" ]; then
  BATTERY_ICON=""
elif [ $TOTAL -gt "20" ]; then
  BATTERY_ICON=""
else
  if [ ! -e /tmp/batterynotification ]; then
    touch /tmp/batterynotification
    notify-send "Warning: Low battery!"
  fi
  if [ $(( $(date +%s) % 2 )) -eq 0 ]; then
    BATTERY_ICON=""
  else
    BATTERY_ICON=""
  fi
fi


if [ $STATUS != "Discharging" ] ; then
  BATTERY_ICON=""
  if [ -e /tmp/batterynotification ]; then
    rm /tmp/batterynotification
  fi
fi

case $BLOCK_BUTTON in
  1) notify-send "
  Battery $(acpi -b | cut -c 12-)
  "
  ;;
esac

echo "$BATTERY_ICON[$PERCENT]"
