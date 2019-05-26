#!/bin/bash

setup_symlinks() {
    readonly links=(
    bash_aliases
    bashrc
    coffeelint.json
    eslintrc.yml
    keynavrc
    mozilla
    redshift.conf
    rubocop.yml
    tmux
    tmux.conf
    toprc
    vim
    vimrc
    profile
    jshintrc
    gitignore
    reek
    clang-format
    reek
    inputrc
    stylelintrc
    thunderbird
    gtkrc-2.0
    CPPLINT.cfg
    xsessionrc
    )

    for link in "${links[@]}"; do
        local from="$HOME/.config/$link"
        local to="$HOME/.$link"

        if [[ ! -e "$from" ]]; then
            echo "NO CONFIG: $from"
            continue
        fi

        if [[ -L "$to" ]]; then
            if [[ ! -e "$to" ]]; then
                echo "FIXING BROKEN LINK: $to"
                rm "$to"
            else
                continue
            fi
        else
            if [[ -f "$to" ]]; then
                echo "CONFIG EXISTS: $to"
                rm -iv "$to"
            fi
        fi

        ln -sv "$from" "$to"
    done

    if [[ -e "$HOME/.CPPLINT.cfg" ]]; then
        mv -v "$HOME/.CPPLINT.cfg" "$HOME/CPPLINT.cfg"
    fi

    if ! ls "$HOME/.config/mozilla/firefox/"*/chrome &> /dev/null; then
        ln -sv ~/.config/mozilla-chrome-tweaks ~/.config/mozilla/firefox/*/chrome
    fi
}

setup_services() {
    local -r pcspkr_config='/etc/modprobe.d/pcspkr-blacklist.conf'
    if [[ ! -f "$pcspkr_config" ]]; then
        echo
        echo "sudo cp ~/.config/pcspkr-blacklist.conf $pcspkr_config"
    fi

    local -r sysctl_config='/etc/sysctl.d/99-sysctl.conf'
    if ! grep -q '^kernel.sysrq=502' "$sysctl_config"; then
        echo
        echo "echo \"kernel.sysrq=502\" | sudo tee $sysctl_config"
    fi

    git config --global pull.rebase true
    git config --global alias.review 'push origin @:refs/for/master'
    git config --global alias.s 'status'
    git config --global color.ui auto
    git config --global core.excludesfile ~/.gitignore

    if ! grep -q '\[user\]' "$HOME/.gitconfig"; then
        echo
        echo 'Don'\''t forget to add git user'
    fi
}

setup_external_tools() {
    local -r tools=(
        fzf
    )
    local -r lib_path="$HOME/.local/lib"
    local -r bin_path="$HOME/.local/bin"

    for tool in "${tools[@]}"; do
        if [[ ! -d "$lib_path/$tool" ]]; then
            echo "$tool is not installed at $lib_path"
            continue;
        fi

        local search_path="$lib_path/$tool"
        if [[ -d "$search_path/bin" ]]; then
            search_path="$search_path/bin"
        fi

        for file in "$search_path"/*; do
            if [[ ! -d "$file" && -x "$file" ]]; then
                # TODO: update broken links
                if [[ ! -f "$bin_path/$(basename "$file")" ]]; then
                    ln -sv "$file" "$bin_path/"
                fi
            fi
        done
    done

}

setup_symlinks
setup_services
setup_external_tools

# Ubuntu 16 case
#sudo apt-mark hold tmux
#sudo apt-mark hold vim
#sudo apt-mark hold vim-common
#sudo apt-mark hold libevent
#sudo apt-mark hold libevent-2.1.8
