# Profiling
# zmodload zsh/zprof

# for Elcapitan
# [El Capitanにしたらzsh上でのPATHが上書きされた - すぎゃーんメモ](http://d.hatena.ne.jp/sugyan/20151211/1449833480)
setopt no_global_rcs

if [ -z $TMUX ]; then
  export PATH=/usr/local/opt/gnu-sed/libexec/gnubin:$PATH
  export PATH=/usr/local/bin:$PATH
  export PKG_CONFIG_PATH=/usr/lib/pkgconfig:/usr/local/lib/pkgconfig
fi

#=============================
# rbenv
#=============================
if [ -d ${HOME}/.rbenv  ] ; then
  export PATH=${HOME}/.rbenv/bin:${HOME}/.rbenv/shims:${PATH}
  eval "$(rbenv init - --no-rehash)"
fi
