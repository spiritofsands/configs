#!/bin/bash
ln -sv ~/.config/mozilla-chrome-tweaks ~/.config/mozilla/firefox/*/chrome
ln -sv ~/.config/bash_aliases ~/.bash_aliases
ln -sv ~/.config/bashrc ~/.bashrc
ln -sv ~/.config/coffeelint.json ~/coffeelint.json
ln -sv ~/.config/eslintrc.yml ~/.eslintrc.yml
ln -sv ~/.config/keynavrc ~/.keynavrc
ln -sv ~/.config/mozilla ~/.mozilla
ln -sv ~/.config/redshift.conf ~/.redshift.conf
ln -sv ~/.config/rubocop.yml ~/.rubocop.yml
ln -sv ~/.config/tmux ~/.tmux
ln -sv ~/.config/tmux.conf ~/.tmux.conf
ln -sv ~/.config/toprc ~/.toprc
ln -sv ~/.config/vim ~/.vim
ln -sv ~/.config/vimrc ~/.vimrc
ln -sv ~/.config/profile ~/.profile
ln -sv ~/.config/mozilla-chrome-tweaks/ ~/.config/mozilla/firefox/*/chrome
ln -sv ~/.config/babelrc ~/.babelrc
ln -sv ~/.config/jshintrc ~/.jshintrc
ln -sv ~/.config/gitignore ~/.gitignore
ln -sv ~/.config/reek ~/.reek
ln -sv ~/.config/clang-format ~/.clang-format
ln -sv ~/.config/reek ~/.reek
ln -sv ~/.config/inputrc ~/.inputrc
ln -sv ~/.config/stylelintrc ~/.stylelintrc

mkdir -pv ~/.config/autostart-scripts
ln -sv "$(command -v birdtray)" ~/.config/autostart-scripts/
ln -sv "$(command -v keynav)" ~/.config/autostart-scripts/
ln -sv "$(command -v redshift)" ~/.config/autostart-scripts/
ln -sv "$(command -v ssh-add.sh)" ~/.config/autostart-scripts/
ln -sv "$(command -v unclutter)" ~/.config/autostart-scripts/

git config --global pull.rebase true
git config --global alias.review 'git push origin @:refs/for/master'
git config --global color.ui auto
git config --global core.excludesfile ~/.gitignore

echo 'Don'\''t forget to add git user'
