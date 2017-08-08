#!/usr/bin/env python3

###############################################################################
# Imports                                                                     #
###############################################################################

import os


###############################################################################
# Constants                                                                   #
###############################################################################

user_dir = os.path.expanduser("~")


###############################################################################
# Main script                                                                 #
###############################################################################

def main():

    filepath = os.path.realpath(__file__)
    current_dir = os.path.dirname(filepath)
    files_dir = os.path.join(current_dir, "files")

    dotfiles = os.listdir(files_dir)

    for dotfile in dotfiles:
        source = os.path.join(files_dir, dotfile)
        dest = os.path.join(user_dir, dotfile)
        if os.path.isfile(dest):
            os.remove(dest)
        os.symlink(source, dest)


if __name__ == '__main__':
    main()
