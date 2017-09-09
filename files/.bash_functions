
function _go_complete_()
{
    local cmd="${1##*/}"
    local word=${COMP_WORDS[COMP_CWORD]}
    local line=${COMP_LINE}

    COMPREPLY=($(go.py --complete "$line" | tr -d "'[]," ))
}

complete -F _go_complete_ go

function git_help(){
    echo "st: git status"
    echo "aa: git add ."
    echo "cm: git commit"
    echo "pull: git pull"
    echo "push: git push"
    echo "gd: git diff"
}
