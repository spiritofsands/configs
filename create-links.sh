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
babelrc
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
grkrc-2.0
)

for link in "${links[@]}"; do
	ln -sv "$HOME/.config/$link" "$HOME/.$link"
done

ln -sv ~/.config/mozilla-chrome-tweaks ~/.config/mozilla/firefox/*/chrome
ln -sv ~/.config/CPPLINT.cfg ~/CPPLINT.cfg

echo 'sudo cp ~/.config/lock-before-sleep@.service /etc/systemd/system/lock-before-sleep@.service'
echo 'sudo systemctl daemon-reload'
echo 'sudo systemctl enable lock-before-sleep@'

echo 'sudo cp pcspkr-blacklist.conf /etc/modprobe.d/'

git config --global pull.rebase true
git config --global alias.review 'push origin @:refs/for/master'
git config --global alias.s 'status'
git config --global color.ui auto
git config --global core.excludesfile ~/.gitignore

echo 'Don'\''t forget to add git user'
