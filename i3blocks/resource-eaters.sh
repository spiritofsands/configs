#!/bin/bash

readonly resource="${1?}"
readonly high_level=50

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

readonly resource_ps="$(ps -ew --format "%$resource=,comm=" "--sort=-%$resource" | head -n 1)"
resource_percent="${resource_ps# *}"
resource_percent="${resource_percent%% *}"
resource_name="${resource_ps#* }"
resource_name="${resource_name#* }"

if [[ "${resource_percent%.*}" -ge "$high_level" ]]; then
    echo "${resource^^} $(print_name "$resource_name") $resource_percent%"
fi
