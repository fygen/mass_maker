#!/bin/bash

# Define functions
builder() {
    echo "Rebuilding projects in directories containing 'ex'..."
    find "$1" -type d -name '*ex*' | xargs -I@ make -C @ re 
    find "$1" -type d -name '*ex*' | xargs -I@ make -C @ clean 
} 

executor() {
    echo -e "Executing all executable files outside the .git directory...\n"
    find "$1" -type f -not -path '*/.git/*' -exec test -x {} \; -exec echo -e "\nExecuting: {}\n" \; -exec {} \;
}

fcleaner() {
    echo "Cleaning up builds in directories containing 'ex'..."
    find "$1" -type d -name '*ex*' | xargs -I@ make -C @ fclean
}

cleaner() {
    echo "Cleaning up builds in directories containing 'ex'..."
    find "$1" -type d -name '*ex*' | xargs -I@ make -C @ clean
}

leakchecker() {
    echo "Running leak check on all executables..."
    find "$1" -type f -not -path '*/.git/*' -exec test -x {} \; -exec echo -e "\nLeak check: {}\n" \; -exec echo "Running valgrind on: {}" \; -exec valgrind --leak-check=full {} \;
}

installer() {
    echo "Installing..."
    # copy this script to ~/.local/bin
    cp "$0" ~/.local/bin/42maker.sh
    # make it executable
    chmod +x ~/.local/bin/42maker.sh
    # add ~/.local/bin to PATH if not already present
    if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' ~/.zshrc; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
        echo "Added ~/.local/bin to PATH in .zshrc"
    else
        echo "~/.local/bin is already in PATH in .zshrc"
    fi
    # source .zshrc to apply changes
    source ~/.zshrc
    echo "Installation complete. You can now use 42maker.sh from anywhere."
}

navigate()
{
    echo "Navigate to the target directory"
    cd "$1" || { echo "Directory not found: $1"; exit 1; }
}

# Set $DIR based on arguments
if [ -z "$1" ]; then
    DIR=$(pwd)
elif [[ "$1" == "make" || "$1" == "exec" || "$1" == "clean" || "$1" == "fclean" || "$1" == "leak" || "$1" == "install" ]]; then
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
        fclean) 
            echo "Full Cleaning projects..." 
            fcleaner "$DIR"
            exit 0
            ;;
        clean) 
            echo "Cleaning projects..." 
            cleaner "$DIR"
            exit 0
            ;;
        leak)
            echo "Checking for memory leaks..." 
            leakchecker "$DIR"
            exit 0
            ;;
        install)
            echo "Installing 42maker.sh..." 
            installer
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
echo "Usage: $0 [make|exec|clean|fclean|leak] [directory]"
