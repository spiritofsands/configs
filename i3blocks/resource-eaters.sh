#!/bin/bash

print_name() {
    local -r max_len=10
    local -r max_len_no_braces="$((max_len - 2))"
    local name="${1?}"
    name="${name:0:$max_len_no_braces}"

    if [[ "${#name}" -lt "$max_len_no_braces" ]]; then
        spaces_to_add="$(( max_len_no_braces - ${#name} ))"
        name+="$(printf ' %.0s' $(seq 1 $spaces_to_add))"
    fi
    echo "[$name]"
}

readonly cpu_ps="$(ps -ew --format %cpu=,comm= --sort=-%cpu | head -n 1)"
cpu_percent="${cpu_ps# *}"
cpu_percent="${cpu_percent%% *}"
readonly cpu_name="${cpu_ps##* }"

readonly mem_ps="$(ps -ew --format %mem=,comm= --sort=-%mem | head -n 1)"
mem_percent="${mem_ps# *}"
mem_percent="${mem_percent%% *}"
readonly mem_name="${mem_ps##* }"

echo "$(print_name "$mem_name") $cpu_percent% / $(print_name "$cpu_name") $mem_percent%"
