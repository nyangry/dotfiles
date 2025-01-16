#=======================================================
# PATH
#=======================================================
export MANPATH=/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH
export MANPATH=/opt/local/share/man:/opt/local/man:$MANPATH
export NODE_PATH=/usr/local/share/npm/lib/node_modules:$NODE_PATH


# rbenv
if [ -d ${HOME}/.rbenv  ] ; then
  # export PATH=${HOME}/.rbenv/bin:${HOME}/.rbenv/shims:${PATH}
  eval "$(rbenv init - --no-rehash)"
fi

# nodenv
if [ -d ${HOME}/.nodenv  ] ; then
  export PATH=$HOMEBREW_PREFIX/opt/nodenv/bin:$PATH
  eval "$(nodenv init -)"
fi

# pyenv
if [ -d ${HOME}/.pyenv  ] ; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/shims:$PATH"
  if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
fi

# for auto_cd
cdpath=(
  $HOME/workspace/
  $HOME/workspace/mf/
  $cdpath
)

# git diff-highlight
export PATH="$PATH:/opt/homebrew/share/git-core/contrib/diff-highlight"


# user bin
export PATH="$HOME/bin:$PATH"


#=======================================================
# load env
#=======================================================
source ~/.env_vars

#=======================================================
# zsh config
#=======================================================
# completions
fpath=(~/.zsh/completions $fpath)
autoload -U compinit && compinit -C

autoload colors && colors
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

setopt no_flow_control

#cd
setopt auto_cd

setopt auto_pushd

setopt prompt_subst

# historyの共有
setopt share_history

# 重複を記録しない
setopt hist_ignore_dups

# ヒストリに追加されるコマンド行が古いものと同じなら古いものを削除
setopt hist_ignore_all_dups

# スペースで始まるコマンド行はヒストリリストから削除
setopt hist_ignore_space

# 余分な空白は詰めて記録
setopt hist_reduce_blanks

# 古いコマンドと同じものは無視
setopt hist_save_no_dups

# historyコマンドは履歴に登録しない
setopt hist_no_store

# 補完時にヒストリを自動的に展開
setopt hist_expand

# 履歴をインクリメンタルに追加
setopt inc_append_history

# 開始と終了を記録
setopt EXTENDED_HISTORY


setopt interactive_comments

# 履歴ファイルの保存先
export HISTFILE=${HOME}/.zsh_history

# メモリに保存される履歴の件数
export HISTSIZE=1000000

# 履歴ファイルに保存される履歴の件数
export SAVEHIST=1000000

#color
export LSCOLORS=gxfxxxxxcxxxxxxxxxgxgx
export LS_COLORS='di=01;36:ln=01;35:ex=01;32'
export LESS='-g -i -M -R -S -W -z-4 -x4'
export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh %s'


zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'ex=32'

#大文字小文字を意識しない補完
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

#=======================================================

#----------------------------------
# for vcs_info
#----------------------------------
local git==git

function _precmd_vcs_info() {
  LANG=en_US.UTF-8 vcs_info
}
add-zsh-hook precmd _precmd_vcs_info
zstyle ':vcs_info:*' formats "%b" "%s"
zstyle ':vcs_info:*' actionformats "%b|%a" "%s"
function vcs_info_for_git() {
  VCS_GIT_PROMPT="${vcs_info_msg_0_}"
  VCS_GIT_PROMPT_CLEAN="%{${fg[cyan]}%}"
  #VCS_GIT_PROMPT_CLEAN="%{${fg[cyan]}%}"
  VCS_GIT_PROMPT_DIRTY="%{${fg[cyan]}%}"
  #VCS_GIT_PROMPT_DIRTY="%{${fg[yellow]}%}"

  VCS_GIT_PROMPT_ADDED="%{${fg[blue]}%}A%{${reset_color}%}"
  VCS_GIT_PROMPT_MODIFIED="%{${fg[red]}%}!%{${reset_color}%}"
  VCS_GIT_PROMPT_DELETED="%{${fg[red]}%}D%{${reset_color}%}"
  VCS_GIT_PROMPT_RENAMED="%{${fg[yellow]}%}R%{${reset_color}%}"
  VCS_GIT_PROMPT_UNMERGED="%{${fg[red]}%}U%{${reset_color}%}"
  VCS_GIT_PROMPT_UNTRACKED="%{${fg[red]}%}?%{${reset_color}%}"

  INDEX=$($git status --porcelain 2> /dev/null)
  LINE="$(time_since_commit)|"
  if [[ -z "$INDEX" ]];then
    LINE="$LINE${VCS_GIT_PROMPT_CLEAN}${VCS_GIT_PROMPT}%{${reset_color}%}"
  else
    if $(echo "$INDEX" | grep '^UU ' &> /dev/null); then
      STATUS="$VCS_GIT_PROMPT_UNMERGED"
    fi
    if $(echo "$INDEX" | grep '^R ' &> /dev/null); then
      STATUS="$VCS_GIT_PROMPT_RENAMED"
    fi
    if $(echo "$INDEX" | grep '^ D ' &> /dev/null); then
      STATUS="$VCS_GIT_PROMPT_DELETED"
    fi
    if $(echo "$INDEX" | grep '^?? ' &> /dev/null); then
      STATUS="$VCS_GIT_PROMPT_UNTRACKED"
    fi
    if $(echo "$INDEX" | grep '^ M ' &> /dev/null); then
      STATUS="$VCS_GIT_PROMPT_MODIFIED"
    fi
    if $(echo "$INDEX" | grep '^A ' &> /dev/null); then
      STATUS="$VCS_GIT_PROMPT_ADDED"
    elif $(echo "$INDEX" | grep '^M ' &> /dev/null); then
      STATUS="$VCS_GIT_PROMPT_ADDED"
    fi
    LINE="$LINE${VCS_GIT_PROMPT_DIRTY}${VCS_GIT_PROMPT}%{${reset_color}%}$STATUS"
  fi
  echo "${LINE}"
}

function minutes_since_last_commit {
    now=`date +%s`
    last_commit=`$git log --pretty=format:'%at' -1 2>/dev/null`
    if $lastcommit ; then
      seconds_since_last_commit=$((now-last_commit))
      minutes_since_last_commit=$((seconds_since_last_commit/60))
      echo $minutes_since_last_commit
    else
      echo "-1"
    fi
}

function time_since_commit() {
  local -A pc

  if [[ -n "${vcs_info_msg_0_}" ]]; then
      local MINUTES_SINCE_LAST_COMMIT=`minutes_since_last_commit`
      if [ "$MINUTES_SINCE_LAST_COMMIT" -eq -1 ]; then
        COLOR="%{${fg[red]}%}"
        local SINCE_LAST_COMMIT="${COLOR}uncommitted%{${reset_color}%}"
      else
        if [ "$MINUTES_SINCE_LAST_COMMIT" -gt 30 ]; then
          COLOR="%{${fg[red]}%}"
        elif [ "$MINUTES_SINCE_LAST_COMMIT" -gt 10 ]; then
          COLOR="%{${fg[red]}%}"
        else
          COLOR="%{${fg[red]}%}"
        fi
        local SINCE_LAST_COMMIT="${COLOR}$(minutes_since_last_commit)m%{${reset_color}%}"
      fi
      echo $SINCE_LAST_COMMIT
  fi
}

function vcs_info_with_color() {

  if [[ `pwd` =~ ".*\/mnts\/.*" ]]; then
    return ""
  fi

  VCS_PROMPT_PREFIX="("
  VCS_PROMPT_SUFFIX=")"

  VCS_NOT_GIT_PROMPT="%{${fg[green]}%}${vcs_info_msg_0_}%{${reset_color}%}"

  if [[ -n "${vcs_info_msg_0_}" ]]; then
    if [[ "${vcs_info_msg_1_}" = "git" ]]; then
      STATUS=$(vcs_info_for_git)
    else
      STATUS=${VCS_NOT_GIT_PROMPT}
    fi
    echo "${VCS_PROMPT_PREFIX}${STATUS}${VCS_PROMPT_SUFFIX}"
  fi
}

function current_dir() {
  echo `pwd | rev | cut -d '/' -f 1 | rev`
}

# PROMPT='$(rbenv_version) %{${fg[green]}%}${USER}%{${reset_color}%}:$(current_dir)$(vcs_info_with_color) %{${fg[yellow]}%}$%{${reset_color}%} '
PROMPT='$(current_dir)$(vcs_info_with_color) %{${fg[yellow]}%}$%{${reset_color}%} '

alias b='bundle; bundle clean'
# alias vim='nvim --startuptime ~/nvim_startuptime_log'
alias vim='nvim'
alias vimrc='vim ~/.vimrc'
alias tmuxconf='vim ~/.tmux.conf'
alias zshrc='vim ~/.zshrc'
alias dotfiles='~/dotfiles'
alias tailf='tail -f'
alias ls="ls -GF"
alias la='ls -GFa'
alias ll='ls -GFl'
alias lla='ls -aGFl'
alias hosts='sudo vi /etc/hosts'
alias updatedb='sudo /usr/libexec/locate.updatedb'
if [[ -x `which colordiff` ]]; then
  # alias diff="colordiff -u --side-by-side --suppress-common-lines"
  alias diff='colordiff -u'
else
  alias diff='diff -u'
fi
# http://orangeclover.hatenablog.com/entry/20110201/1296511181
alias clear2="echo -e '\026\033c'"
alias ag='ag -S'
alias rsp='bin/rails s -p'
alias rc='bin/rails c'
alias railsdbm='bin/rails db:migrate'
alias railsdbmt='RAILS_ENV=test bin/rails db:migrate'
alias railsdbr='bin/rails db:rollback'
alias railsdbrt='RAILS_ENV=test bin/rails db:rollback'
alias railsra='bin/rails ridgepole:apply'
alias railsrat='RAILS_ENV=test bin/rails ridgepole:apply'
alias r='bin/rspec'
alias rspec='bin/rspec'
alias rails='bin/rails'
alias fs='bin/fast_seed'
alias fst='RAILS_ENV=test bin/fast_seed'


# ----------------------
# Git Aliases
# http://postd.cc/git-command-line-shortcuts/
# ----------------------
alias s='gss'
alias ga='git add'
alias gaa='git add .'
alias gai='git add -i'
alias gap='git add -p'
alias gan='git add -N'
alias gaaa='git add -A'
alias gb='git branch'
alias gba='git branch -a'
alias gbc='git rev-parse --abbrev-ref HEAD'
alias gbd='git branch -D'
alias gbm='git branch -m'
alias gc='git commit'
alias gca='git commit --amend'
alias gcam='git commit --allow-empty -m'
alias gcm='git commit -m'
alias gcmim='git commit --allow-empty -m "Init milestone"'
alias gcmit='git commit --allow-empty -m "Init topic"'
alias gcmtw='git commit -m "tweak"'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcom='git checkout master'
alias gcop='git checkout -p'
alias gcln='git clean -n'
alias gclf='git clean -f'
alias gd='git diff'
alias gda='git diff HEAD'
alias gdc='git diff --cached'
alias gf='git remote update --prune'
alias gl='git log'
alias glp='git log -p'
alias glg='git log --graph --oneline --decorate'
alias gld='git log --pretty=format:"%h %ad %s" --date=short'
alias gm='git merge --no-ff'
# alias gp='git pull'
alias gps='git push'
alias gpsf='git push --force'
alias gpso='git push -u origin `git rev-parse --abbrev-ref HEAD`'
alias grb='git rebase'
alias grbum='git rebase upstream/master'
alias grbom='git rebase origin/master'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbs='git rebase --skip'
alias grv='git revert'
alias grh='git reset HEAD --'
alias grp='git reset -p'
alias gs='git status'
alias gss='git status -s'
alias gst='git stash save -u'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash show'
alias gstsp='git stash show -p'

# ----------------------
# Git Function
# ----------------------
# Git log find by commit message
function glf() { $git log --all --grep="$1"; }


#history setting
# [# 履歴ファイルの保存先 export HISTFILE=${HOME}/.zsh_history  # メモリに保存される履歴の件数 export HISTSIZE=1000  # 履歴ファイルに保存される履歴の件数 export SAVEHIST=100000  # 重複を記録しない setopt hist_ignore_dups  # 開始と終了を記録 setopt EXTENDED_HISTORY](http://qiita.com/syui/items/c1a1567b2b76051f50c4)

# zshで特定のコマンドをヒストリに追加しない条件を柔軟に設定する
# http://mollifier.hatenablog.com/entry/20090728/p1
zshaddhistory() {
  local line=${1%%$'\n'}
  local cmd=${line%% *}

  # 以下の条件をすべて満たすものだけをヒストリに追加する
  [[ ${#line} -ge 10
      # && ${cmd} != (l|l[sal])
      # && ${cmd} != (c|cd)
      # && ${cmd} != (m|man)
      # && ${cmd} != (r[mr])
      # && ${cmd} != (kill)
      # && ${cmd} != (tmux)
      # && ${cmd} != (vim)
      # && ${cmd} != (bundle)
      # && ${cmd} != (rails)
      # && ${cmd} != (gfu|grb|gco|gcob|ga|gclf|gps|gpsuo)
  ]]
}

#title
precmd() {
  # echo -ne "\033]0;${USER}@${HOST}\007"
  # print -Pn "\e]0;%n@%m: %~\a"
  print -Pn "\e]0;$(current_dir)\a"
}


#=============================
# tmux
#=============================
# is_tmux_running() {
#     [ ! -z "$TMUX" ]
# }
# shell_has_started_interactively() {
#     [ ! -z "$PS1" ]
# }
# resolve_alias() {
#     cmd="$1"
#     while \
#         whence "$cmd" >/dev/null 2>/dev/null \
#         && [ "$(whence "$cmd")" != "$cmd" ]
#     do
#         cmd=$(whence "$cmd")
#     done
#     echo "$cmd"
# }
#
#
# if ! is_tmux_running && shell_has_started_interactively; then
#   if whence tmux >/dev/null 2>/dev/null; then
#       $(resolve_alias "tmux")
#   fi
# fi
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator


#=============================
# custom PATH for Rails
#=============================
# add-zsh-hook precmd is_rails_dir
#
# function is_rails_dir () {
#   if [ -e './config/environment.rb' ]; then
#     add_rails_bin_path_for_binstubs
#   fi
# }
#
# function add_rails_bin_path_for_binstubs () {
#   export PATH=./bin:$PATH
#   export PATH=./.bundle/bin:$PATH
# }

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"


#=============================
# cache rake tasks
#=============================
_cachefile_updated_at() {
  echo $(stat -f%m .rake_tasks)
}

_rakefile_updated_at() {
  echo $(stat -f%m Rakefile)
}

_gemfile_updated_at() {
  echo $(stat -f%m Gemfile)
}

_generate_cachefile() {
  rake --silent --tasks 2> /dev/null | cut  -f 2 -d " " > .rake_tasks
}

_rake() {
  if [ -f Rakefile ]; then
    if [ ! -f .rake_tasks ] || \
       [ "`cat .rake_tasks | wc -l`" = "0" ] || \
       [ `_cachefile_updated_at` -lt `_rakefile_updated_at` ] || \
       [ -f Gemfile -a `_cachefile_updated_at` -lt `_gemfile_updated_at` ]; then
      _generate_cachefile
    fi
    compadd `cat .rake_tasks`
  fi
}

compdef _rake rake

#============================
# fzf
#============================
function select-history() {
  BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
  CURSOR=$#BUFFER
}
zle -N select-history
bindkey '^r' select-history


#============================
# npm のローカルモードでインストールした実行モジュールにパスを通す設定
# http://qiita.com/umechiki/items/a1de903a2e5e27f5c606
#============================
add-zsh-hook precmd is_npm_dir

function is_npm_dir () {
  if [ -e './package.json' ]; then
    add_npm_bin_path_for_binstubs
  fi
}

function add_npm_bin_path_for_binstubs () {
  PATH=./node_modules/.bin:$PATH
}
export PATH="/usr/local/sbin:$PATH"

# direnv
export DIRENV_LOG_FORMAT=
eval "$(direnv hook zsh)"


###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}
COMP_WORDBREAKS=${COMP_WORDBREAKS/@/}
export COMP_WORDBREAKS

if type complete &>/dev/null; then
  _npm_completion () {
    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$COMP_CWORD" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${COMP_WORDS[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###

#=======================================================
# zplug
#=======================================================
export ZPLUG_HOME=$HOMEBREW_PREFIX/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "zplug/zplug"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
# zplug "zsh-users/zsh-history-substring-search"
# zplug "zsh-users/zsh-syntax-highlighting", defer:2

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

zplug load # --verbose

#=======================================================
# homebrew
#=======================================================
# export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1
# export HOMEBREW_NO_INSTALL_CLEANUP=1


# Profiling
# if (which zprof > /dev/null) ;then
#   zprof | less
# fi

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/masuyama.daisuke/.cache/lm-studio/bin"
