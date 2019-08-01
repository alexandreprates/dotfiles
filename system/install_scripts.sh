#!/usr/bin/env bash

function link_file() {
  ORIGIN=$1
  DESTINATION=${ORIGIN#"."}
  ORIGIN=$(pwd)$DESTINATION
  sudo ln -sv $ORIGIN $DESTINATION
}

for file in $(find  -type f -not -name install_scripts.sh); do
  link_file $file
done

sudo udevadm control --reload
