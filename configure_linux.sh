#!/bin/bash

create_link() {
    PREFIX="$1"
    SOURCE="$2"
    DESTINATION="$3"
    DESTINATION_PATH=$(dirname $DESTINATION)

    if [ ! -d "$DESTINATION_PATH" ]; then
        echo $PREFIX mkdir -vp $DESTINATION_PATH
    fi

    if [ -f "$DESTINATION" ]; then
        echo $PREFIX mv -v "$DESTINATION" "$DESTINATION.original"
    fi
    echo $PREFIX ln -s $SOURCE $DESTINATION
}

install() {
    for SOURCE in $(find $1 -type f); do
        BASE_DIR=$(echo $SOURCE | sed "s|$1||g")
        DESTINATION=$(echo $BASE_DIR | sed "s|/home|$HOME|g" | sed "s|/_|/.|g")

        if [[ $DESTINATION =~ ^$HOME ]]; then
            PREFIX=""
        else
            PREFIX="sudo"
        fi

        create_link "$PREFIX" $SOURCE $DESTINATION
    done
}

HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="Desktop Selection"
TITLE="Select flavor to configure"
MENU="Choose one of the following options:"

OPTIONS=(1 "Cinnamon"
         2 "i3"
         3 "Ubuntu Server")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
        1)
            install ./flavors/cinnamon
            ;;
        2)
            install ./flavors/i3
            ;;
        3)
            install ./flavors/ubuntu_server
            ;;
esac
