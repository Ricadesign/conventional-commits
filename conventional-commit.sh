#!/bin/sh

#Colors
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[1;33m'
reset='\033[0m'

# Function to display the help message
show_help() {
    echo "Usage: ./conventional-commit.sh <directory_path> [options]"
    echo "Options:"
    echo "  -h, --help    Show this help message"
    echo "  --disable   Disable commit-msg hook"
    echo ""
    echo "Note: Provide the directory path where the script should act as the first parameter."
}

# Check if the -h or --help parameter is provided
if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
    show_help
    exit 0
fi

path="${1:-./}"

# Disable hook if --disable parameter is provided as second parameter
if [ "$2" == "--disable" ]; then
    cd $path
    rm ".git/hooks/commit-msg" 2>/dev/null 
    if [ $? -ne 0 ]; then
        echo "${red}ERROR: commit-msg hook is not configured${reset}"
        exit 1
    fi
    echo "${green}Hook disabled succesfully!${reset}"
    exit 0
fi

# Check if the directory path is provided as the first parameter
if [ -z "$1" ]; then
    echo "${red}Error: Directory path is required.${reset}"
    show_help
    exit 1
fi

cd $path
echo "Operating in $(pwd)"
echo "Creating commit-msg hook..."
if [ -f ".git/hooks/commit-msg" ]; then
    echo "${yellow}WARNING: Commit-msg hook already configured${reset}"
    exit 0
fi
cp .git/hooks/commit-msg.sample .git/hooks/commit-msg

echo "Generating code to commit-msg hook..."
cat << EOF > ".git/hooks/commit-msg"
#!/bin/sh

commit_msg=\$(cat "\${1:?Missing commit message file}")

commit_msg_type_regex='feat|fix|refactor|style|test|docs|build|lang|chore'
commit_msg_scope_regex='.{1,20}'
commit_msg_subject_regex='.{1,100}'
commit_msg_regex="^(\${commit_msg_type_regex})(\(\${commit_msg_scope_regex}\))?: (\${commit_msg_subject_regex})\$"

if ! [[ "\$commit_msg" =~ (\${commit_msg_regex}) ]]; then
    echo "ERROR: Invalid commit message format" >&2
    echo "\$commit_msg" >&2
    error="true"
fi

if [ -n "\$error" ]; then
    exit 1
fi
EOF

echo "${green}Hook configured succesfully!${reset}"
