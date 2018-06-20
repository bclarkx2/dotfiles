#!/bin/bash

# dbus-update-activation-environment --systemd DISPLAY
# export SSH_AUTH_SOCK

exec xrdb .Xresources & i3
