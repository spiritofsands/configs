#!/bin/bash

links=(
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
)

for link in "${links[@]}"; do
    if [[ -e "$HOME/.config/$link" ]]; then
        echo "Already exists: $HOME/.config/$link"
        continue
    fi

    if [[ ! -e "$HOME/.config/$link" ]]; then
        echo "BROKEN LINK: $link"
        continue
    fi

	ln -sv "$HOME/.config/$link" "$HOME/.$link"
done

if ls $HOME/.config/mozilla/firefox/*/chrome &> /dev/null; then
    echo "Already exists: $HOME/.config/mozilla/firefox/*/chrome"
else
    ln -sv ~/.config/mozilla-chrome-tweaks ~/.config/mozilla/firefox/*/chrome
fi

if [[ -e "$HOME/CPPLINT.cfg" ]]; then
    echo "Already exists: $HOME/CPPLINT.cfg"
else
    ln -sv ~/.config/CPPLINT.cfg ~/CPPLINT.cfg
fi

echo
echo "sed \"s/%USER%/$USER/\" ~/.config/lock-on-suspend@.service | sudo tee /etc/systemd/system/lock-on-suspend@.service > /dev/null"
echo "sudo systemctl enable lock-on-suspend@$USER"
echo
echo 'sudo cp ~/.config/00-keyboard.conf /X11/xorg.conf.d/'
echo
echo 'sudo cp ~/.config/pcspkr-blacklist.conf /etc/modprobe.d/'

git config --global pull.rebase true
git config --global alias.review 'push origin @:refs/for/master'
git config --global alias.s 'status'
git config --global color.ui auto
git config --global core.excludesfile ~/.gitignore
echo
echo 'Don'\''t forget to add git user'
