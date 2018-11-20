#!/bin/bash
ln -sv mozilla-chrome-tweaks mozilla/firefox/*/chrome
ln -sv /home/kos/.config/bash_aliases /home/kos/.bash_aliases
ln -sv /home/kos/.config/bashrc /home/kos/.bashrc
ln -sv /home/kos/.config/coffeelint.json /home/kos/coffeelint.json
ln -sv /home/kos/.config/eslintrc.yml /home/kos/.eslintrc.yml
ln -sv /home/kos/.config/keynavrc /home/kos/.keynavrc
ln -sv /home/kos/.config/mozilla /home/kos/.mozilla
ln -sv /home/kos/.config/redshift.conf /home/kos/.redshift.conf
ln -sv /home/kos/.config/rubocop.yml /home/kos/.rubocop.yml
ln -sv /home/kos/.config/tmux /home/kos/.tmux
ln -sv /home/kos/.config/tmux.conf /home/kos/.tmux.conf
ln -sv /home/kos/.config/toprc /home/kos/.toprc
ln -sv /home/kos/.config/vim /home/kos/.vim
ln -sv /home/kos/.config/vimrc /home/kos/.vimrc
ln -sv /home/kos/.config/profile /home/kos/.profile
ln -sv /home/kos/.config/mozilla-chrome-tweaks/ /home/kos/.config/mozilla/firefox/*/chrome
ln -sv /home/kos/.config/babelrc /home/kos/.babelrc
ln -sv /home/kos/.config/jshintrc /home/kos/.jshintrc
ln -sv /home/kos/.config/gitignore /home/kos/.gitignore
ln -sv /home/kos/.config/reek /home/kos/.reek
ln -sv /home/kos/.config/clang-format /home/kos/.clang-format
ln -sv /home/kos/.config/reek /home/kos/.reek
ln -sv ~/.config/inputrc ~/.inputrc
ln -sv ~/.config/stylelintrc ~/.stylelintrc

git config --global pull.rebase true
git config --global alias.review 'git push origin @:refs/for/master'
git config --global color.ui auto
git config --global core.excludesfile ~/.gitignore

echo 'Don'\''t forget to add git user'
