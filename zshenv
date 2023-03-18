# Profiling
# zmodload zsh/zprof

# for Elcapitan
# [El Capitanにしたらzsh上でのPATHが上書きされた - すぎゃーんメモ](http://d.hatena.ne.jp/sugyan/20151211/1449833480)
setopt no_global_rcs

# locale
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# if [ -z $TMUX ]; then
  export PATH=/usr/local/opt/gnu-sed/libexec/gnubin:$PATH
  export PATH=/usr/local/bin:$PATH
  export PATH=/usr/local/share/git-core/contrib/diff-highlight:$PATH
  export PKG_CONFIG_PATH=/usr/lib/pkgconfig:/usr/local/lib/pkgconfig
# fi

export XDG_CONFIG_HOME=$HOME/.config
