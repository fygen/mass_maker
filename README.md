# mass-maker

A lightweight and flexible Bash script to manage project directories with ease. Automate repetitive tasks such as building, cleaning, and executing files, all from a single script.

## Features

- **Build Projects**: Rebuild directories containing `*ex*` with `make`.
- **Execute Files**: Automatically find and run executable files outside `.git` directories.
- **Clean Builds**: Clean up builds in directories containing `*ex*`.
- **Custom Directory Navigation**: Navigate to a specified directory and perform tasks there.
- **Default Behavior**: Works seamlessly with the current directory when no arguments are provided.

## Usage

1. Clone this repository:
   ```bash
   git clone https://github.com/fygen/mass-maker.git
   cd auto-project-manager

2. Make the script executable:
   ```bash
   chmod +x mass_maker.sh

3. Run the script:
   ```bash
   ./mass_maker.sh <command>

### Commands
- `make`  : Build projects in directories containing `*ex*`.
- `exec`  : Execute all executable files outside `.git` directories.
- `clean` : Clean builds in directories containing `*ex*`.
- `[path]`: Navigate to the specified directory.

If no command is provided, the script defaults to the current working directory.

## Examples

- **Build Projects**:
  ```bash
  ./script.sh make
  ```

- **Execute Files**:
  ```bash
  ./script.sh exec
  ```

- **Clean Builds**:
  ```bash
  ./script.sh clean
  ```

- **Specify a Directory**:
  ```bash
  ./script.sh /path/to/your/directory
  ```

## Why Use `mass-maker`?

- Save time with automated project management.
- Simplify directory-based operations.
- Improve productivity with a single, reusable script.

## License

This project is licensed under the MIT License. Feel free to use, modify, and distribute it as you like.
