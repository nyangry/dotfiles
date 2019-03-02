#!/usr/bin/env bash

add_directories()
{
  echo "[mkdir] Add directories"
  mkdir $HOME/.config
}

delete_old_files()
{
  echo "[DELETE] Delete the old files"
  rm $HOME/.bashrc
  rm $HOME/.zshrc
  rm $HOME/.zshenv
  rm $HOME/.agignore
  rm $HOME/.config/nvim
  rm $HOME/.vim
  rm $HOME/.vimrc
  rm $HOME/.gitattributes
  rm $HOME/.gitconfig
  rm $HOME/.gitignore
  rm $HOME/.tmux.conf
  rm $HOME/.peco
  rm $HOME/.ctags
  rm $HOME/.gemrc
  rm $HOME/.bundle/config
  rm $HOME/.railsrc
  rm $HOME/.rspec
  rm $HOME/.pryrc
  rm $HOME/.my.cnf
  rm $HOME/monitor.sh
}

symlink_files()
{
  echo "[Symlink] Symlinking files"
  ln -s $HOME/dotfiles/bashrc    $HOME/.bashrc
  ln -s $HOME/dotfiles/zshrc     $HOME/.zshrc
  ln -s $HOME/dotfiles/zshenv    $HOME/.zshenv
  ln -s $HOME/dotfiles/agignore     $HOME/.agignore
  ln -s $HOME/dotfiles/nvim     $HOME/.config/nvim
  ln -s $HOME/dotfiles/vimfiles     $HOME/.vim
  ln -s $HOME/dotfiles/vimrc     $HOME/.vimrc
  ln -s $HOME/dotfiles/gitattributes $HOME/.gitattributes
  ln -s $HOME/dotfiles/gitconfig $HOME/.gitconfig
  ln -s $HOME/dotfiles/gitignore $HOME/.gitignore
  ln -s $HOME/dotfiles/tmux.conf $HOME/.tmux.conf
  ln -s $HOME/dotfiles/peco $HOME/.peco
  ln -s $HOME/dotfiles/ctags $HOME/.ctags
  ln -s $HOME/dotfiles/gemrc     $HOME/.gemrc
  ln -s $HOME/dotfiles/bundle_config $HOME/.bundle/config
  ln -s $HOME/dotfiles/railsrc $HOME/.railsrc
  ln -s $HOME/dotfiles/rspec $HOME/.rspec
  ln -s $HOME/dotfiles/pryrc $HOME/.pryrc
  ln -s $HOME/dotfiles/app_config/my.cnf $HOME/.my.cnf
  ln -s $HOME/dotfiles/monitor.sh $HOME/monitor.sh
}

add_zsh_completions()
{
  mkdir ~/.zsh
  ln -s ~/dotfiles/zsh_completions ~/.zsh/completions
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
add_directories 1
delete_old_files 1
symlink_files 1
# add_zsh_completions 1
# install_neovim 1

echo "[DONE]  All done."

cd $HOME
