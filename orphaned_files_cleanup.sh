#!/bin/bash
# orphaned_files_cleanup.sh: Clean up orphaned home directories (cross-platform)

if [[ "$OSTYPE" == "linux"* ]]; then
    if [ -d /home ]; then
        for dir in /home/*; do
            user=$(basename "$dir")
            if ! id "$user" &>/dev/null; then
                echo "Orphaned home directory found: $dir"
                # Uncomment the next line to remove the directory
                # rm -rf "$dir"
            fi
        done
    else
        echo "/home does not exist."
    fi
elif [[ "$OS" == "Windows_NT" ]]; then
    for dir in /c/Users/*; do
        user=$(basename "$dir")
        net user "$user" >nul 2>&1
        if [ $? -ne 0 ]; then
            echo "Orphaned user directory found: $dir"
            # Uncomment the next line to remove the directory
            # rmdir /S /Q "$dir"
        fi
    done
else
    echo "Unsupported OS."
fi 