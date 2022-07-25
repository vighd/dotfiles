#!/bin/bash
CONFIG_SET=false

while ! $CONFIG_SET; do
  if [ ! -f "/sys/devices/platform/i8042/serio1/serio2/sensitivity" ]; then
    sleep 1
  else
    echo -n 1 > /sys/devices/platform/i8042/serio1/serio2/drift_time
    #echo -n 132 > /sys/devices/platform/i8042/serio1/serio2/sensitivity
    #echo -n 158 > /sys/devices/platform/i8042/serio1/serio2/speed
    #echo -n 6 > /sys/devices/platform/i8042/serio1/serio2/inertia
    CONFIG_SET=true
  fi
done
