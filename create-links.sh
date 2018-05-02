#!/bin/bash
ln -s mozilla-chrome-tweaks mozilla/firefox/*/chrome
ln -s /home/kos/.config/bash_aliases /home/kos/.bash_aliases
ln -s /home/kos/.config/bashrc /home/kos/.bashrc
ln -s /home/kos/.config/coffeelint.json /home/kos/coffeelint.json
ln -s /home/kos/.config/eslintrc.yml /home/kos/.eslintrc.yml
ln -s /home/kos/.config/keynavrc /home/kos/.keynavrc
ln -s /home/kos/.config/mozilla /home/kos/.mozilla
ln -s /home/kos/.config/redshift.conf /home/kos/.redshift.conf
ln -s /home/kos/.config/rubocop.yml /home/kos/.rubocop.yml
ln -s /home/kos/.config/tmux /home/kos/.tmux
ln -s /home/kos/.config/tmux.conf /home/kos/.tmux.conf
ln -s /home/kos/.config/toprc /home/kos/.toprc
ln -s /home/kos/.config/vim /home/kos/.vim
ln -s /home/kos/.config/vimrc /home/kos/.vimrc
ln -s /home/kos/.config/Xresources /home/kos/.Xresources
ln -s /home/kos/.config/profile /home/kos/.profile
ln -s /home/kos/.config/mozilla-chrome-tweaks/ /home/kos/.config/mozilla/firefox/*/chrome
ln -s /home/kos/.config/moc/ /home/kos/.moc
ln -s /home/kos/.config/babelrc /home/kos/.babelrc
ln -s /home/kos/.config/jshintrc /home/kos/.jshintrc
ln -s /home/kos/.config/gitignore /home/kos/.gitignore
ln -s /home/kos/.config/reek /home/kos/.reek
ln -s /home/kos/.config/clang-format /home/kos/.clang-format
ln -s /home/kos/.config/reek /home/kos/.reek
ln -s ~/.config/inputrc ~/.inputrc
ln -s ~/.config/stylelintrc ~/.stylelintrc
git config --global core.excludesfile ~/.gitignore

echo
echo 'sudo cp Xresources-xdm /etc/X11/xdm/Xresources'
echo 'sudo cp slock@.service /etc/systemd/system/slock@.service'
echo 'sudo systemctl daemon-reload'
echo 'sudo systemctl enable slock@'
