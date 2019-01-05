#!/bin/bash

unpushed_config=0

cd ~/.config || exit
if [[ -n $(git status -s) ]]; then
    unpushed_config=1
fi

unpushed_bin=0
cd ~/bin || exit
if [[ -n $(git status -s) ]]; then
    unpushed_bin=1
fi

if [[ "$unpushed_config" -eq 1 || "$unpushed_bin" -eq 1 ]]; then
    if [[ "$unpushed_config" -eq 1 ]]; then
        echo -n 'config'
    fi

    if [[ "$unpushed_bin" -eq 1 ]]; then
        if [[ "$unpushed_config" -eq 1 ]]; then
            echo -n ', '
        fi

        echo -n 'bin'
    fi

    echo
    echo
    echo '#FF0000'
fi
