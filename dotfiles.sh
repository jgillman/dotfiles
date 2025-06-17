#!/usr/bin/env bash

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

print_usage() {
    echo "Usage: $0 [install|uninstall|help]"
    echo ""
    echo "Commands:"
    echo "  install    - Install dotfiles"
    echo "  uninstall  - Remove installed dotfiles and restore backups"
    echo "  help       - Show this help message (default)"
}

install_dotfiles() {
    echo "Installing dotfiles from $DOTFILES_DIR"

    # Find all .symlink files
    local linkables
    mapfile -t linkables < <(find "$DOTFILES_DIR" -name "*.symlink" -type f)

    if [ ${#linkables[@]} -eq 0 ]; then
        echo "No .symlink files found!"
        return 1
    fi

    local skip_all=false
    local overwrite_all=false
    local backup_all=false

    for linkable in "${linkables[@]}"; do
        local filename
        filename="$(basename "$linkable" .symlink)"
        local target="$HOME/.$filename"

        local overwrite=false
        local backup=false

        # Check if target already exists
        if [[ -e "$target" || -L "$target" ]]; then
            if [[ "$skip_all" == false && "$overwrite_all" == false && "$backup_all" == false ]]; then
                echo ""
                echo "File already exists: $target"
                echo "What do you want to do?"
                echo "[s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all"
                read -r -n 1 choice
                echo ""

                case "$choice" in
                    o) overwrite=true ;;
                    b) backup=true ;;
                    O) overwrite_all=true ;;
                    B) backup_all=true ;;
                    S) skip_all=true ;;
                    s|*) continue ;;
                esac
            fi

            if [[ "$overwrite" == true || "$overwrite_all" == true ]]; then
                echo "Removing $target"
                rm -rf "$target"
            elif [[ "$backup" == true || "$backup_all" == true ]]; then
                echo "Backing up $target to $target.backup"
                mv "$target" "$target.backup"
            elif [[ "$skip_all" == true ]]; then
                continue
            fi
        fi

        echo "Linking $linkable -> $target"
        ln -s "$linkable" "$target"
    done

    echo ""
    echo "✅ Dotfiles installation complete!"
}

uninstall_dotfiles() {
    echo "Uninstalling dotfiles..."

    # Find all .symlink files
    local linkables
    mapfile -t linkables < <(find "$DOTFILES_DIR" -name "*.symlink" -type f)

    for linkable in "${linkables[@]}"; do
        local filename
        filename="$(basename "$linkable" .symlink)"
        local target="$HOME/.$filename"

        # Remove symlink if it exists and points to our dotfile
        if [[ -L "$target" ]]; then
            local link_target
            link_target="$(readlink "$target")"
            if [[ "$link_target" == "$linkable" ]]; then
                echo "Removing symlink: $target"
                rm "$target"
            fi
        fi

        # Restore backup if it exists
        if [[ -f "$target.backup" ]]; then
            echo "Restoring backup: $target.backup -> $target"
            mv "$target.backup" "$target"
        fi
    done

    echo ""
    echo "✅ Dotfiles uninstallation complete!"
}

# Main script logic
case "${1:-help}" in
    install)
        install_dotfiles
        ;;
    uninstall)
        uninstall_dotfiles
        ;;
    help|--help|-h)
        print_usage
        ;;
    *)
        echo "Unknown command: $1"
        print_usage
        exit 1
        ;;
esac
