# Conventional Commit Script

This script sets up a commit-msg hook in a Git repository to enforce a conventional commit message format based on the Conventional Commits specification.

## Installation and Configuration

```bash
./conventional-commit.sh <directory_path> [options]
```

- `<directory_path>`: Provide the directory path where the script should act as the first parameter.

## Options

- `-h, --help`: Show the help message.
- `--disable`: Disable the commit-msg hook.

## Usage

1. Run the script with the desired directory path as the first parameter:
   ```bash
   ./conventional-commit.sh <directory_path>
   ```
   This will create the commit-msg hook in the specified directory.

2. To disable the commit-msg hook, use the `--disable` option as the second parameter:
   ```bash
   ./conventional-commit.sh <directory_path> --disable
   ```
   This will remove the commit-msg hook from the specified directory.

## Commit Message Format

The script enforces the following format for commit messages:

```
<type>(<scope>): <subject>
```

- `<type>`: Type of the commit. It can be one of the following values: `feat`, `fix`, `refactor`, `style`, `test`, `docs`, `build`, `lang`, `chore`.
- `<scope>` (optional): Scope or context of the commit. It should be a short description (up to 20 characters).
- `<subject>`: A concise and descriptive message (up to 100 characters) about the commit.

If the commit message does not match the specified format, an error will be displayed, and the commit will be rejected.

## Example

```bash
./conventional-commit.sh my_project/
```

This example runs the script in the `my_project/` directory, setting up the commit-msg hook for the Git repository located in that directory.

Please note that this script assumes you have appropriate permissions to modify the Git repository and its hooks.
