# File for aliases

# builtin changes

# safer delete
alias rm=trash-put

# reassign sl because HOLY CRAP is it annoying
alias sl="new_sl"

# command to open a new terminal setup
alias lt="load-terminal"

# simple to clear terminal
alias c="clear"

alias clipboard="xclip -sel clip"


# Script aliases

# easy directory navigation change
# source is required so it can change the working directory of
# parent shell
alias goto="source goto"

# open cpp and h files
alias bopen="cpp_both_open.py"

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


##########
# SVN
##########

# svn quick diff
alias sd="svn_colordiff"


##########
# Pizzapi
##########

# quick pizzapi ssh access
alias pp="pizzapi ssh pi"
alias pps="pizzapi sftp"
