#!/bin/bash
ln -s mozilla-chrome-tweaks mozilla/firefox/*/chrome
ln -s /home/kos/.config/bash_aliases ~/.bash_aliases
ln -s /home/kos/.config/bashrc ~/.bashrc
ln -s /home/kos/.config/coffeelint.json ~/coffeelint.json
ln -s /home/kos/.config/eslintrc.yml ~/.eslintrc.yml
ln -s /home/kos/.config/keynavrc ~/.keynavrc
ln -s /home/kos/.config/mozilla ~/.mozilla
ln -s /home/kos/.config/redshift.conf ~/.redshift.conf
ln -s /home/kos/.config/rubocop.yml ~/.rubocop.yml
ln -s /home/kos/.config/tmux ~/.tmux
ln -s /home/kos/.config/tmux.conf ~/.tmux.conf
ln -s /home/kos/.config/toprc ~/.toprc
ln -s /home/kos/.config/vim ~/.vim
ln -s /home/kos/.config/vimrc ~/.vimrc
ln -s /home/kos/.config/Xresources ~/.Xresources
ln -s ~/.config/profile ~/.profile
ln -s ~/.config/mozilla-chrome-tweaks/ ~/.config/mozilla/firefox/*/chrome
ln -s ~/.config/moc/ ~/.moc
ln -s .config/babelrc .babelrc
echo
echo 'sudo cp Xresources-xdm /etc/X11/xdm/Xresources'
echo 'sudo cp slock@.service /etc/systemd/system/slock@.service'
echo 'sudo systemctl daemon-reload'
echo 'sudo systemctl enable slock@'
