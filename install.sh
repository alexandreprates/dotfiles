#!/usr/bin/env bash

# Dotfiles Installation Script
# Automatically detects OS and runs the appropriate configuration

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to download repository as zip when git is not available
download_zip_repository() {
    local repo_url="https://github.com/alexandreprates/dotfiles"
    local zip_url="$repo_url/archive/refs/heads/main.zip"
    local target_dir="$HOME/.dotfiles"
    local temp_dir
    local zip_file

    print_status "Git not available. Downloading repository as ZIP..."

    # Create temporary directory
    temp_dir=$(mktemp -d)
    zip_file="$temp_dir/dotfiles.zip"

    # Check if curl or wget is available
    if command -v curl >/dev/null 2>&1; then
        if curl -L -o "$zip_file" "$zip_url"; then
            print_status "Repository downloaded successfully with curl"
        else
            print_error "Failed to download repository with curl"
            rm -rf "$temp_dir"
            return 1
        fi
    elif command -v wget >/dev/null 2>&1; then
        if wget -O "$zip_file" "$zip_url"; then
            print_status "Repository downloaded successfully with wget"
        else
            print_error "Failed to download repository with wget"
            rm -rf "$temp_dir"
            return 1
        fi
    else
        print_error "Neither curl nor wget is available. Cannot download repository."
        rm -rf "$temp_dir"
        return 1
    fi

    # Extract zip file
    print_status "Extracting repository to $target_dir..."

    # Remove existing target directory if it exists
    if [[ -d "$target_dir" ]]; then
        print_warning "Directory $target_dir exists. Removing..."
        rm -rf "$target_dir"
    fi

    # Extract using unzip (most compatible) or try alternatives
    if command -v unzip >/dev/null 2>&1; then
        if unzip -q "$zip_file" -d "$temp_dir"; then
            # Move the extracted directory to target location
            mv "$temp_dir/dotfiles-main" "$target_dir"
            print_success "Repository extracted successfully"
        else
            print_error "Failed to extract ZIP file with unzip"
            rm -rf "$temp_dir"
            return 1
        fi
    elif command -v tar >/dev/null 2>&1; then
        # Try with tar if unzip is not available (some minimal systems)
        if tar -xf "$zip_file" -C "$temp_dir" 2>/dev/null; then
            mv "$temp_dir/dotfiles-main" "$target_dir"
            print_success "Repository extracted successfully with tar"
        else
            print_error "Failed to extract ZIP file. Neither unzip nor compatible tar available."
            rm -rf "$temp_dir"
            return 1
        fi
    else
        print_error "No extraction tool available (unzip or tar). Cannot extract repository."
        rm -rf "$temp_dir"
        return 1
    fi

    # Clean up temporary files
    rm -rf "$temp_dir"
    return 0
}

# Function to clone or update dotfiles repository
setup_repository() {
    local repo_url="https://github.com/alexandreprates/dotfiles.git"
    local target_dir="$HOME/.dotfiles"

    print_status "Setting up dotfiles repository..."

    # Check if git is installed
    if ! command -v git >/dev/null 2>&1; then
        print_warning "Git is not installed. Falling back to ZIP download..."
        return download_zip_repository
    fi

    # If directory already exists and is a git repo, update it
    if [[ -d "$target_dir/.git" ]]; then
        print_status "Dotfiles directory already exists. Updating..."
        cd "$target_dir"

        # Check if we have uncommitted changes
        if ! git diff-index --quiet HEAD --; then
            print_warning "You have uncommitted changes in $target_dir"
            read -p "Do you want to stash them and continue? (y/N): " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                git stash push -m "Stashed by install script on $(date)"
                print_status "Changes stashed successfully"
            else
                print_error "Cannot continue with uncommitted changes"
                return 1
            fi
        fi

        # Pull latest changes
        if git pull origin main; then
            print_success "Repository updated successfully"
        else
            print_warning "Failed to pull latest changes, continuing with current version..."
        fi
    elif [[ -d "$target_dir" ]] && [[ ! -d "$target_dir/.git" ]]; then
        # Directory exists but is not a git repo - likely from previous ZIP download
        print_warning "Directory $target_dir exists but is not a git repository"
        read -p "Do you want to remove it and download fresh? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            rm -rf "$target_dir"
            return download_zip_repository
        else
            print_error "Cannot continue with existing non-git directory"
            return 1
        fi
    else
        # Clone the repository
        print_status "Cloning dotfiles repository to $target_dir..."

        if git clone "$repo_url" "$target_dir"; then
            print_success "Repository cloned successfully to $target_dir"
        else
            print_error "Failed to clone repository"
            return 1
        fi
    fi

    # Change to the dotfiles directory
    cd "$target_dir"
    return 0
}

# Function to detect operating system
detect_os() {
    local os_name

    if [[ "$OSTYPE" == "darwin"* ]]; then
        os_name="mac"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Check if we're on a desktop environment or server
        if command -v gnome-session >/dev/null 2>&1 || command -v cinnamon >/dev/null 2>&1; then
            # Desktop environment detected, check which one
            if command -v cinnamon >/dev/null 2>&1; then
                os_name="cinnamon"
            elif command -v i3 >/dev/null 2>&1 || [[ "$XDG_CURRENT_DESKTOP" == "i3" ]]; then
                os_name="i3"
            else
                # Default to cinnamon for other desktop environments
                os_name="cinnamon"
            fi
        else
            # No desktop environment, assume server
            os_name="ubuntu_server"
        fi
    else
        print_error "Unsupported operating system: $OSTYPE"
        return 1
    fi

    echo "$os_name"
}

# Function to check if flavor exists
check_flavor_exists() {
    local flavor="$1"
    local flavor_dir="$HOME/.dotfiles/flavors/$flavor"

    if [[ ! -d "$flavor_dir" ]]; then
        print_error "Flavor directory not found: $flavor_dir"
        return 1
    fi

    local configure_script="$flavor_dir/configure.sh"
    if [[ ! -f "$configure_script" ]]; then
        print_error "Configure script not found: $configure_script"
        return 1
    fi

    if [[ ! -x "$configure_script" ]]; then
        print_warning "Configure script is not executable, making it executable..."
        chmod +x "$configure_script"
    fi

    return 0
}

# Function to run configuration
run_configuration() {
    local flavor="$1"
    local flavor_dir="$HOME/.dotfiles/flavors/$flavor"
    local configure_script="$flavor_dir/configure.sh"

    print_status "Running configuration for $flavor..."
    cd "$flavor_dir"

    if ./configure.sh; then
        print_success "Configuration for $flavor completed successfully!"
        return 0
    else
        print_error "Configuration for $flavor failed!"
        return 1
    fi
}

# Main installation function
main() {
    echo "================================="
    echo "   Dotfiles Installation Script   "
    echo "================================="
    echo

    # Setup repository
    if ! setup_repository; then
        exit 1
    fi
    echo

    # Detect OS
    print_status "Detecting operating system..."
    local detected_os
    if ! detected_os=$(detect_os); then
        exit 1
    fi

    print_success "Detected OS: $detected_os"

    # Allow manual override with command line argument
    local target_flavor="$detected_os"
    if [[ $# -gt 0 ]]; then
        target_flavor="$1"
        print_warning "Manual override: using flavor '$target_flavor' instead of detected '$detected_os'"
    fi

    # Check if flavor exists
    if ! check_flavor_exists "$target_flavor"; then
        print_error "Available flavors:"
        ls -1 "$HOME/.dotfiles/flavors/" 2>/dev/null || echo "  No flavors found"
        exit 1
    fi

    # Confirm installation
    echo
    print_status "Ready to install dotfiles for: $target_flavor"
    read -p "Do you want to continue? (y/N): " -n 1 -r
    echo

    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_warning "Installation cancelled."
        exit 0
    fi

    # Run configuration
    if run_configuration "$target_flavor"; then
        echo
        print_success "Dotfiles installation completed successfully!"
        print_status "You may need to restart your shell or source your configuration files."
    else
        echo
        print_error "Installation failed. Please check the error messages above."
        exit 1
    fi
}

# Show help
show_help() {
    echo "Usage: $0 [flavor]"
    echo
    echo "Automatically downloads, detects and installs dotfiles for your operating system."
    echo
    echo "This script will:"
    echo "  1. Clone/update the dotfiles repository to \$HOME/.dotfiles"
    echo "  2. Auto-detect your operating system"
    echo "  3. Run the appropriate configuration script"
    echo
    echo "Available flavors:"
    if [[ -d "$HOME/.dotfiles/flavors" ]]; then
        ls -1 "$HOME/.dotfiles/flavors/" 2>/dev/null | sed 's/^/  - /'
    else
        echo "  (Repository not yet cloned)"
    fi
    echo
    echo "Options:"
    echo "  -h, --help    Show this help message"
    echo
    echo "Examples:"
    echo "  $0            # Auto-detect OS and install"
    echo "  $0 mac        # Force install Mac flavor"
    echo "  $0 i3         # Force install i3 flavor"
    echo
    echo "Note: The script can be run from anywhere and will automatically"
    echo "      setup the repository in \$HOME/.dotfiles"
}

# Parse command line arguments
case "${1:-}" in
    -h|--help)
        show_help
        exit 0
        ;;
    *)
        main "$@"
        ;;
esac