#!/bin/bash

# Define the dotfiles directory
DOTFILES_DIR="$HOME/.dotfiles"

create_link() {
    PREFIX="$1"
    SOURCE="$2"
    DESTINATION="$3"
    DESTINATION_PATH=$(dirname "$DESTINATION")

    if [ ! -d "$DESTINATION_PATH" ]; then
        echo "$PREFIX mkdir -vp $DESTINATION_PATH"
        $PREFIX mkdir -vp "$DESTINATION_PATH"
    fi

    if [ -f "$DESTINATION" ] || [ -L "$DESTINATION" ]; then
        echo "$PREFIX mv -v \"$DESTINATION\" \"$DESTINATION.original\""
        $PREFIX mv -v "$DESTINATION" "$DESTINATION.original"
    fi

    echo "$PREFIX ln -s \"$SOURCE\" \"$DESTINATION\""
    $PREFIX ln -s "$SOURCE" "$DESTINATION"
}

install() {
    local flavor_path="$1"

    # Check if flavor directory exists
    if [ ! -d "$flavor_path" ]; then
        echo "Error: Flavor directory $flavor_path not found!"
        return 1
    fi

    for SOURCE in $(find "$flavor_path" -type f -name packages.txt -prune -o -type f -print); do
        # Skip if it's the packages.txt file
        if [[ "$SOURCE" == *"packages.txt" ]]; then
            continue
        fi

        # Get the relative path from the flavor's home directory
        if [[ "$SOURCE" == *"/home/"* ]]; then
            RELATIVE_PATH="${SOURCE#*home/}"

            # Convert underscore prefix to dot prefix for dotfiles
            DESTINATION_FILE=$(echo "$RELATIVE_PATH" | sed 's/^_/\./')

            # Build the full destination path
            DESTINATION="$HOME/$DESTINATION_FILE"
        elif [[ "$SOURCE" == *"/etc/"* ]]; then
            # Handle system files in /etc
            DESTINATION="${SOURCE#*etc/}"
            DESTINATION="/etc/$DESTINATION"
        else
            continue
        fi

        if [[ $DESTINATION =~ ^$HOME ]]; then
            PREFIX=""
        else
            PREFIX="sudo"
        fi

        create_link "$PREFIX" "$SOURCE" "$DESTINATION"
    done
}

# Check if dotfiles directory exists
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "Error: Dotfiles directory $DOTFILES_DIR not found!"
    echo "Please ensure the dotfiles repository is cloned to $DOTFILES_DIR"
    exit 1
fi

# Change to dotfiles directory to ensure proper path resolution
cd "$DOTFILES_DIR"

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
            install "$DOTFILES_DIR/flavors/cinnamon"
            ;;
        2)
            install "$DOTFILES_DIR/flavors/i3"
            ;;
        3)
            install "$DOTFILES_DIR/flavors/ubuntu_server"
            ;;
esac
