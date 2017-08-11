# File for aliases

# builtin changes

# safer delete
alias rm=trash-put

# reassign sl because HOLY CRAP is it annoying
alias sl="new_sl"

# command to open a new terminal setup
alias lt="load-terminal && exit"

# simple to clear terminal
alias c="clear"


# Script aliases

# easy directory navigation change
# source is required so it can change the working directory of
# parent shell
alias go="source go"

# open cpp and h files
alias bopen="cpp_both_open.py"

# onx environment
alias set_env="source /home/brian/MyONX/env_scripts/set_gemini_env_vars.sh"

# onxPush
alias push="~/MyONX/build_scripts/onxPush.sh"

# onx test commit
alias onxTestCommit="bash $onx_test_commit"

# onx ssh
alias ossh="onxssh"

# pylint
alias pylint3="/usr/local/bin/pylint"

# extra lines on the terminal
alias li="lines"

# edit bash files
alias edbash="edit_bash_configs"
alias rb="source refresh_bash"
alias rs="refresh_subl"

# test script
alias utest="li 40 && ./test"

# change env var
alias cev="source change_env_var"

# edit onx IP
alias ed_ip="source edit_onx_ip"

# git quick status
alias st="git status"

# svn quick diff
alias sd="svn_colordiff"
