# dotfiles

Repository for various linux dotfiles.

Organized as a GNU stow directory, with target=$HOME. Each subdirectory represents dotfiles from a given application.


## Usage

1. Home directory
`cd`

2. Clone dotfile repository
`git clone git@github.com:bclarkx2/dotfiles`

3. Enter dotfile repository
`cd dotfiles`

4. Disperse dotfiles using GNU stow
`./disperse` -- Disperse all packages
or
`stow <package>` -- Disperse specific packages


## Additional commands

Delete all dotfiles
`./disperse -D`

Restow all dotfiles
`./disperse -R`
