# Profiling
# zmodload zsh/zprof

# for Elcapitan
# [El Capitanにしたらzsh上でのPATHが上書きされた - すぎゃーんメモ](http://d.hatena.ne.jp/sugyan/20151211/1449833480)
setopt no_global_rcs

# if [ -z $TMUX ]; then
  export PATH=/usr/local/opt/gnu-sed/libexec/gnubin:$PATH
  export PATH=/usr/local/bin:$PATH
  export PATH=/usr/local/share/git-core/contrib/diff-highlight:$PATH
  export PATH="$HOME/.config/yarn/global/node_modules/.bin:$PATH"
  export PKG_CONFIG_PATH=/usr/lib/pkgconfig:/usr/local/lib/pkgconfig
# fi

export XDG_CONFIG_HOME=$HOME/.config

# rbenv
if [ -d ${HOME}/.rbenv  ] ; then
  # export PATH=${HOME}/.rbenv/bin:${HOME}/.rbenv/shims:${PATH}
  eval "$(rbenv init - --no-rehash)"
fi

# pyenv
if [ -d ${HOME}/.pyenv  ] ; then
  # export PATH=${HOME}/.pyenv/bin:${HOME}/.pyenv/shims:${PATH}
  eval "$(pyenv init -)"
fi

# for auto_cd
cdpath=(
  $HOME/workspace/
  $HOME/workspace/mf/
  $cdpath
)
