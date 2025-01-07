#!/usr/bin/env bash

add_directories()
{
  echo "[mkdir] Add directories"
  mkdir -p $HOME/.config
  mkdir -p $HOME/bin
}

delete_old_files()
{
  echo "[DELETE] Delete the old files"
  rm -f $HOME/.bashrc
  rm -f $HOME/.zshrc
  rm -f $HOME/.zshenv
  rm -f $HOME/.config/nvim
  rm -f $HOME/.vim
  rm -f $HOME/.vimrc
  rm -f $HOME/.editorconfig
  rm -f $HOME/.gitattributes
  rm -f $HOME/.gitconfig
  rm -f $HOME/.gitignore
  rm -f $HOME/.tmux.conf
  rm -f $HOME/.ctags
  rm -f $HOME/.gemrc
  rm -f $HOME/.rgignore
  rm -f $HOME/.bundle/config
  rm -f $HOME/monitor.sh
  rm -f $HOME/bin/ulog
}

symlink_files()
{
  echo "[Symlink] Symlinking files"
  ln -sf $HOME/dotfiles/bashrc    $HOME/.bashrc
  ln -sf $HOME/dotfiles/zshrc     $HOME/.zshrc
  ln -sf $HOME/dotfiles/zshenv    $HOME/.zshenv
  ln -sf $HOME/dotfiles/nvim     $HOME/.config/nvim
  ln -sf $HOME/dotfiles/vimfiles     $HOME/.vim
  ln -sf $HOME/dotfiles/vimrc     $HOME/.vimrc
  ln -sf $HOME/dotfiles/editorconfig $HOME/.editorconfig
  ln -sf $HOME/dotfiles/gitattributes $HOME/.gitattributes
  ln -sf $HOME/dotfiles/gitconfig $HOME/.gitconfig
  ln -sf $HOME/dotfiles/gitignore $HOME/.gitignore
  ln -sf $HOME/dotfiles/tmux.conf $HOME/.tmux.conf
  ln -sf $HOME/dotfiles/ctags $HOME/.ctags
  ln -sf $HOME/dotfiles/gemrc     $HOME/.gemrc
  ln -sf $HOME/dotfiles/rgignore $HOME/.rgignore
  ln -sf $HOME/dotfiles/bundle_config $HOME/.bundle/config
  ln -sf $HOME/dotfiles/monitor.sh $HOME/monitor.sh
  ln -sf $HOME/dotfiles/ulog $HOME/bin/ulog
}

add_zsh_completions()
{
  mkdir -p ~/.zsh
  ln -sf ~/dotfiles/zsh_completions ~/.zsh/completions
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
