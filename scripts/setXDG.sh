#!/bin/sh

#FILE=/etc/profile.d/setXDG.sh

if ! [ -n "$XDG_CONFIG_HOME" ]; then
       XDG_CONFIG_HOME=$HOME/.config
       export XDG_CONFIG_HOME
fi

[ -d "$XDG_CONFIG_HOME" ] || mkdir "$XDG_CONFIG_HOME"
