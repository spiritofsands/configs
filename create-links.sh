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
    Xresources
    moc
    thunderbird
    gtkrc-2.0
    CPPLINT.cfg
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

    if ! ls $HOME/.config/mozilla/firefox/*/chrome &> /dev/null; then
        ln -sv ~/.config/mozilla-chrome-tweaks ~/.config/mozilla/firefox/*/chrome
    fi
}

setup_services() {
    if [[ ! -f /etc/systemd/system/lock-on-suspend@.service ]]; then
        echo
        echo "sed \"s/%USER%/$USER/\" ~/.config/lock-on-suspend@.service | sudo tee /etc/systemd/system/lock-on-suspend@.service > /dev/null"
        echo "sudo systemctl enable lock-on-suspend@$USER"
    fi

    if [[ ! -f /etc/X11/xorg.conf.d/00-keyboard.conf ]]; then
        echo
        echo 'sudo cp ~/.config/00-keyboard.conf /etc/X11/xorg.conf.d/'
    fi

    if [[ ! -f /etc/modprobe.d/pcspkr-blacklist.conf ]]; then
        echo
        echo 'sudo cp ~/.config/pcspkr-blacklist.conf /etc/modprobe.d/'
    fi

    local sysctl_config='/etc/sysctl.d/99-sysctl.conf'
    if ! grep -q '^kernel.sysrq=502' "$sysctl_config"; then
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

setup_font_size() {
    if [[ "$1" == '--big' ]]; then
        readonly fontsize=18
    else
        readonly fontsize=12
    fi

    local -r dpi_configs="$HOME/.config/dpi-dependent"
    cd "$dpi_configs" || exit
    #TODO: add mozilla CSS as well
    local configs=( $(find -type f) )

    for config in "${configs[@]}"; do
        local from="${config#.}"
        local to="$HOME/.config$from"

        if [[ -e "$to" ]]; then
            echo "OVERWRITING: $to"
        fi

        local dir
        dir="$(dirname "$to")"
        if [[ ! -d "$dir" ]]; then
            mkdir -v "$dir"
        fi

        sed "s/%FONT_SIZE%/$fontsize/" "$dpi_configs$from" > "$to"
    done
}

setup_external_tools() {
    local -r tools=(
        clipnotify
        clipmenu
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

setup_font_size "$1"
setup_symlinks
setup_services
setup_external_tools
