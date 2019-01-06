#!/bin/bash

config_flag=0
cd ~/.config || exit
git fetch
if [[ -n $(git status -s) ]]; then
    config_flag=1
fi

config_updates=0
if git status | grep -q 'is behind'; then
    config_flag=1
    config_updates=1
fi

bin_flag=0
cd ~/bin || exit
git fetch
if [[ -n $(git status -s) ]]; then
    bin_flag=1
fi

bin_updates=0
if git status | grep -q 'is behind'; then
    bin_flag=1
    bin_updates=1
fi

if [[ "$config_flag" -eq 1 || "$bin_flag" -eq 1 ]]; then
    if [[ "$config_flag" -eq 1 ]]; then
        echo -n 'config'
        if [[ "$config_updates" -eq 1 ]]; then
            echo -n '*'
        fi
    fi

    if [[ "$bin_flag" -eq 1 ]]; then
        if [[ "$config_flag" -eq 1 ]]; then
            echo -n ', '
        fi

        echo -n 'bin'
        if [[ "$bin_updates" -eq 1 ]]; then
            echo -n '*'
        fi
    fi

    echo
    echo
    echo '#FF0000'
fi
