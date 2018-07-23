#!/bin/bash

# retrieves current working directory using xcwd package from AUR
dir=$(xcwd)

# opens another terminal the in current working directory (or user's home)
if [ "$#" -ne 0 ]; then
    exec termite -d "$dir" -e "$@"
else
    exec termite -d "$dir"
fi
