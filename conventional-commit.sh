#!/bin/sh

#Colors
red='\033[0;31m'
green='\033[0;32m'
reset='\033[0m'

# Function to display the help message
show_help() {
    echo "Usage: ./conventional-commit.sh <directory_path>"
    echo "Options:"
    echo "  -h    Show this help message"
    echo ""
    echo "Note: Provide the directory path where the script should act as the first parameter."
}

# Check if the -h parameter is provided
if [ "$1" == "-h" ]; then
    show_help
    exit 0
fi

# Check if the directory path is provided as the first parameter
if [ -z "$1" ]; then
    echo "${red}Error: Directory path is required.${reset}"
    show_help
    exit 1
fi


path="${1:-./}"

cd $path
echo "Operating in $(pwd)"
echo "Creating commit-msg hook..."
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
