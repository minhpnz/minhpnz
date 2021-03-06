#!/bin/bash



# clone repo
git clone git@github.com:minhphan81299/minhphan81299.git

# exit if clone repo failed
[[ "$?" != "0" ]] && exit 1

# make sure brew already installed
if ! command -v "brew" &> /dev/null; then
  echo "brew does not install, please install brew first! If you don't use MacOS, please comment these commands to skip it :))" >&2
  exit 1
fi

# install brew packages
xargs brew install <./brew/leaves
xargs brew install --cask <./brew/casks

# install Hack fonts
cp -r ./fonts/hack/* ~/Library/fonts

# install Liberation Mono fonts
cp -r ./fonts/liberation-mono/* ~/Library/fonts

# install oh-my-zsh
curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | bash

# set default zsh
sudo sh -c "echo $(which zsh) >> /etc/shells" && chsh -s $(which zsh)

# save current dir
_curdir="$PWD"

# goto $HOME
cd $HOME

# link config
ln -s $_curdir/.zshrc
ln -s $_curdir/.vimrc
ln -s $_curdir/.tmux.conf

cd $_curdir

# update vim
mkdir -p $HOME/.vim/colors
cp -r colors $HOME/.vim/

# install plugins for zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# download iterm shell integration
curl -L https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh



