#!/usr/bin/env bash

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

# Check if dotfiles directory exists
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "Error: Dotfiles directory $DOTFILES_DIR not found!"
    echo "Please ensure the dotfiles repository is cloned to $DOTFILES_DIR"
    exit 1
fi

echo "Configuring macOS flavor..."

# echo "Install brew"
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# brew update

# echo "Installing packages from Brewfile..."
# brew bundle --file "$DOTFILES_DIR/flavors/mac/Brewfile"

echo "Install Go2Dir..."
curl https://raw.githubusercontent.com/alexandreprates/go2dir/master/install | bash

echo "Creating symlinks..."
# Change to dotfiles directory to ensure proper path resolution
cd "$DOTFILES_DIR"

for SOURCE in $(find "$DOTFILES_DIR/flavors/mac/home" -type f); do
    # Get the relative path from the home directory
    RELATIVE_PATH="${SOURCE#$DOTFILES_DIR/flavors/mac/home/}"

    # Convert underscore prefix to dot prefix for dotfiles
    DESTINATION_FILE=$(echo "$RELATIVE_PATH" | sed 's/^_/\./')

    # Build the full destination path
    DESTINATION="$HOME/$DESTINATION_FILE"

    if [[ $DESTINATION =~ ^$HOME ]]; then
        PREFIX=""
    else
        PREFIX="sudo"
    fi

    create_link "$PREFIX" "$SOURCE" "$DESTINATION"
done

echo "macOS configuration complete!"