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
  rm $HOME/.config/nvim
  rm $HOME/.vim
  rm $HOME/.vimrc
  rm $HOME/.editorconfig
  rm $HOME/.gitattributes
  rm $HOME/.gitconfig
  rm $HOME/.gitignore
  rm $HOME/.tmux.conf
  rm $HOME/.ctags
  rm $HOME/.gemrc
  rm $HOME/.rgignore
  rm $HOME/.bundle/config
  rm $HOME/monitor.sh
}

symlink_files()
{
  echo "[Symlink] Symlinking files"
  ln -s $HOME/dotfiles/bashrc    $HOME/.bashrc
  ln -s $HOME/dotfiles/zshrc     $HOME/.zshrc
  ln -s $HOME/dotfiles/zshenv    $HOME/.zshenv
  ln -s $HOME/dotfiles/nvim     $HOME/.config/nvim
  ln -s $HOME/dotfiles/vimfiles     $HOME/.vim
  ln -s $HOME/dotfiles/vimrc     $HOME/.vimrc
  ln -s $HOME/dotfiles/editorconfig $HOME/.editorconfig
  ln -s $HOME/dotfiles/gitattributes $HOME/.gitattributes
  ln -s $HOME/dotfiles/gitconfig $HOME/.gitconfig
  ln -s $HOME/dotfiles/gitignore $HOME/.gitignore
  ln -s $HOME/dotfiles/tmux.conf $HOME/.tmux.conf
  ln -s $HOME/dotfiles/ctags $HOME/.ctags
  ln -s $HOME/dotfiles/gemrc     $HOME/.gemrc
  ln -s $HOME/dotfiles/rgignore $HOME/.rgignore
  ln -s $HOME/dotfiles/bundle_config $HOME/.bundle/config
  ln -s $HOME/dotfiles/monitor.sh $HOME/monitor.sh
}

add_zsh_completions()
{
  mkdir ~/.zsh
  ln -s ~/dotfiles/zsh_completions ~/.zsh/completions
}

#
# Main Start
#
add_directories 1
delete_old_files 1
symlink_files 1
# add_zsh_completions 1

echo "[DONE]  All done."

cd $HOME
