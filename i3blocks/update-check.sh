#!/bin/bash

readonly max_days=7

readonly last_update="$(stat --printf '%Y\n' /var/cache/apt/pkgcache.bin)"
readonly now="$(date +%s)"

readonly difference="$(( (now - last_update) / 3600 / 24 ))"

if [[ "$difference" -ge "$max_days" ]]; then
    echo 'UPD'
    echo
    echo '#FF0000'
fi
