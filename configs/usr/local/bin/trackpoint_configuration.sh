#!/bin/bash
CONFIG_SET=false

while ! $CONFIG_SET; do
  if [ ! -f "/sys/devices/platform/i8042/serio1/serio2/sensitivity" ]; then
    sleep 1
  else
    echo -n 2 > /sys/devices/platform/i8042/serio1/serio2/drift_time
    echo -n 180 > /sys/devices/platform/i8042/serio1/serio2/sensitivity
    echo -n 50 > /sys/devices/platform/i8042/serio1/serio2/speed
    CONFIG_SET=true
  fi
done
