#!/usr/bin/env bash

if $(hciconfig | grep DOWN); then
  STATUS="Off"
else
  STATUS="On"
fi

echo " [$STATUS]"
