#!/usr/bin/env bash

delete_old_files()
{
  echo "[DELETE] Delete the old files"
  rm -f $HOME/.agignore
  rm -f $HOME/.vimrc
  rm -f $HOME/.zshrc
  rm -f $HOME/.zshenv
  rm -f $HOME/.gemrc
  rm -f $HOME/.bashrc
  rm -f $HOME/.gitattributes
  rm -f $HOME/.gitconfig
  rm -f $HOME/.gitignore
  rm -f $HOME/.pryrc
  rm -f $HOME/.tmux.conf
  rm -f $HOME/.ctags
  rm -f $HOME/.rspec
  rm -f $HOME/.railsrc
  rm -f $HOME/.peco
  rm -f $HOME/.my.cnf
  rm -f $HOME/.bundle/config
}

symlink_files()
{
  echo "[Symlink] Symlinking files"
  ln -s $HOME/dotfiles/agignore     $HOME/.agignore
  ln -s $HOME/dotfiles/vimrc     $HOME/.vimrc
  ln -s $HOME/dotfiles/vimfiles     $HOME/.vim
  ln -s $HOME/dotfiles/zshrc     $HOME/.zshrc
  ln -s $HOME/dotfiles/zshenv    $HOME/.zshenv
  ln -s $HOME/dotfiles/gemrc     $HOME/.gemrc
  ln -s $HOME/dotfiles/bashrc    $HOME/.bashrc
  ln -s $HOME/dotfiles/gitattributes $HOME/.gitattributes
  ln -s $HOME/dotfiles/gitconfig $HOME/.gitconfig
  ln -s $HOME/dotfiles/gitignore $HOME/.gitignore
  ln -s $HOME/dotfiles/pryrc $HOME/.pryrc
  ln -s $HOME/dotfiles/tmux.conf $HOME/.tmux.conf
  ln -s $HOME/dotfiles/tmuxfiles $HOME/.tmux
  ln -s $HOME/dotfiles/ctags $HOME/.ctags
  ln -s $HOME/dotfiles/rspec $HOME/.rspec
  ln -s $HOME/dotfiles/railsrc $HOME/.railsrc
  ln -s $HOME/dotfiles/peco $HOME/.peco
  ln -s $HOME/dotfiles/app_config/my.cnf $HOME/.my.cnf
  ln -s $HOME/dotfiles/bundle_config $HOME/.bundle/config
  #ln -s $HOME/dotfiles/gitconfig ~/.gitconfig
}

install_neovim()
{
  echo "install neovim"
  # for denite.vim
  pip3 install neovim

  mkdir -p $HOME/.config/nvim
  ln -s $HOME/dotfiles/init.vim $HOME/.config/nvim/init.vim
}

#
# Main Start
#
delete_old_files 1
symlink_files 1
install_neovim

echo "[DONE]  All done."

cd $HOME
