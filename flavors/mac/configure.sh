#!/usr/bin/env bash

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

echo "Configuring macOS flavor..."

# echo "Install brew"
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# brew update

# echo "Installing packages from Brewfile..."
# brew bundle --file ./flavors/mac/Brewfile

echo "Install Go2Dir..."
curl https://raw.githubusercontent.com/alexandreprates/go2dir/master/install | bash

echo "Creating symlinks..."
for SOURCE in $(find ./flavors/mac/home -type f -prune -o -type f -print); do
    BASE_DIR=$(echo $SOURCE | sed "s|./flavors/mac/home||g")
    DESTINATION=$(echo $BASE_DIR | sed "s|/home|$HOME|g" | sed "s|/_|/.|g")

    if [[ $DESTINATION =~ ^$HOME ]]; then
        PREFIX=""
    else
        PREFIX="sudo"
    fi

    create_link "$PREFIX" $SOURCE $DESTINATION
done