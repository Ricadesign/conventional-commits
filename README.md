# Conventional Commit Script

This script sets up a commit-msg hook in a Git repository to enforce a conventional commit message format. It verifies that the commit message follows the pattern defined by the Conventional Commits specification.

## Usage

```bash
./conventional-commit.sh <directory_path>
```

- `<directory_path>`: Provide the directory path where the script should act as the first parameter.

## Options

- `-h`: Show the help message.

## Installation and Configuration

1. Run the script with the desired directory path as the first parameter:
   ```bash
   ./conventional-commit.sh <directory_path>
   ```
   This will create the commit-msg hook in the specified directory.

2. Once the script has been executed, the commit-msg hook will be configured in the Git repository. From now on, every commit message will be validated against the Conventional Commits format.

## Commit Message Format

The script enforces the following format for commit messages:

```
<type>(<scope>): <subject>
```

- `<type>`: Type of the commit. It can be one of the following values: `feat`, `fix`, `refactor`, `style`, `test`, `docs`, `build`, `lang`.
- `<scope>` (optional): Scope or context of the commit. It should be a short description (up to 20 characters).
- `<subject>`: A concise and descriptive message (up to 100 characters) about the commit.

If the commit message does not match the specified format, an error will be displayed, and the commit will be rejected.

## Example

```bash
./conventional-commit.sh my_project/
```

This example runs the script in the `my_project/` directory, setting up the commit-msg hook for the Git repository located in that directory.

Please note that this script assumes you have appropriate permissions to modify the Git repository and its hooks.
