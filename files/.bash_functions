
function _go_complete_()
{
    local cmd="${1##*/}"
    local word=${COMP_WORDS[COMP_CWORD]}
    local line=${COMP_LINE}

    COMPREPLY=($(go.py --complete "$line" | tr -d "'[]," ))
}

complete -F _go_complete_ go
