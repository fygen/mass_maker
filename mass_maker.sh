#!/bin/bash

# Define functions
builder() {
    echo "Rebuilding projects in directories containing 'ex'..."
    find "$1" -type d -name '*ex*' | xargs -I@ make -C @ re 
} 

executor() {
    echo "Executing all executable files outside the .git directory..."
    find "$1" -type f -not -path './.git/*' -exec test -x {} \; -exec {} \;
}

cleaner() {
    echo "Cleaning up builds in directories containing 'ex'..."
    find "$1" -type d -name '*ex*' | xargs -I@ make -C @ fclean
}

navigate()
{
    echo "Navigate to the target directory"
    cd "$1" || { echo "Directory not found: $1"; exit 1; }
}

# Set $DIR based on arguments
if [ -z "$1" ]; then
    DIR=$(pwd)
elif [[ "$1" == "make" || "$1" == "exec" || "$1" == "clean" ]]; then
    DIR=$(pwd)
else
    DIR="$1"
fi

# Check for commands
if [ -n "$1" ]; then
    case $1 in
        make) 
            echo "Building projects..." 
            builder "$DIR"
            exit 0
            ;;
        exec) 
            echo "Executing files..." 
            executor "$DIR"
            exit 0
            ;;
        clean) 
            echo "Cleaning projects..." 
            cleaner "$DIR"
            exit 0
            ;;
        *) 
            # Fallback: Assume $1 is a directory
            navigate "$DIR"
            ;;
    esac
else
    # No command, just navigate to $DIR
    navigate "$DIR"
fi

# Default behavior if no valid command is provided
echo "Navigated to $DIR. Ready for further commands."