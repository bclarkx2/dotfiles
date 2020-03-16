# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Add user directories to PATH
# Note that $HOME/local precedes $HOME/bin. if ~/bin is tracked
# by VCS, anything in it can be overridden by a file in ~/local/bin
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/local/bin:$PATH"

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Source all dotfiles in a .bash_*.d/ subdirectory
function get_dotfile_subdirs(){

    path="$1"

    if [[ -d "$path" && ! -z "$(ls -A "$path")" ]] ; then
        for file in $path/* ;
        do
            source $file
        done
    fi
}

# For a particular type of dotfile, source dotfiles from all
# levels of the hierarchy according to the pattern below.
function get_dotfile(){

    filename="$1"
    dirname="${filename}.d"
    skip_current="$2"

    # First source the actual file
    if [[ -f $HOME/$filename && "$skip_current" != "true" ]]; then
        source $HOME/$filename
    fi

    # Next source any subdirs
    get_dotfile_subdirs "$HOME/$dirname"

    # Now source the local override
    if [ -f $HOME/local/dotfiles/$filename ]; then
        source $HOME/local/dotfiles/$filename
    fi

    # And the local subdirs
    get_dotfile_subdirs "$HOME/local/dotfiles/$dirname"
}

# Source all other types of dotfile, including local overrides
get_dotfile ".bashrc" true
get_dotfile ".bash_variables"
get_dotfile ".bash_functions"
get_dotfile ".bash_aliases"


# set prompt command from file
export PROMPT_COMMAND='PS1="$(pwd.py)" ; pwd > /tmp/where'

# on opening, cd to last directory (if exists)
[[ -f /tmp/where ]] && cd $(cat /tmp/where)

