# Symlink the dotfiles
cd $HOME
ln -s $HOME/dotfiles/.tmux.conf .
echo "source $HOME/dotfiles/zshrc" >> $HOME/.zshrc
