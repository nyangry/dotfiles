#=======================================================
#=======================================================
# zmodload zsh/zprof && zprof


#=======================================================
# PATH
#=======================================================
export MANPATH=/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH
export MANPATH=/opt/local/share/man:/opt/local/man:$MANPATH
export NODE_PATH=/usr/local/share/npm/lib/node_modules:$NODE_PATH

# osx mavericks
bindkey "^[[3~" delete-char

#=======================================================
# Plugins
#=======================================================

#----------------------------------
# cd-bookmark
# http:/qiita.com/mollifier/items/46b080f9a5ca9f29674e/
#----------------------------------
fpath=($HOME/dotfiles/zsh/plugins/cd-bookmark(N-/) $fpath)
autoload -Uz cd-bookmark
alias b='cd-bookmark'


# .zshrc
setopt prompt_subst
autoload -Uz colors
colors
autoload -Uz add-zsh-hook
# for vcs_info
function _precmd_vcs_info() {
  LANG=en_US.UTF-8 vcs_info
}
add-zsh-hook precmd _precmd_vcs_info
autoload -Uz vcs_info
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

  INDEX=$(git status --porcelain 2> /dev/null)
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
    last_commit=`git log --pretty=format:'%at' -1 2>/dev/null`
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

# http://makimoto.hatenablog.com/entry/show-rbenv-version-on-zsh-prompt
# MEMO: 右側に表示させたい場合はこちら
# rbenv_version () {
function rbenv_version () {
  if [[ "`rbenv version | grep '.rbenv/version'`" = "" ]];then
    if [[ "`rbenv version | grep 'RBENV_VERSION'`" = "" ]];then
      local setting="L"
    else 
      local setting="V"
    fi
  else
    local setting="G"
  fi
  # MEMO: 右側に表示させたい場合はこちら
  # RPROMPT="[ruby-`ruby -v | cut -f2 -d' '`($setting)]"
  # ruby- 付き
  # echo "[ruby-`ruby -v | cut -f2 -d' '`($setting)]"
  echo "[`ruby -v | cut -f2 -d' '`($setting)]"
}
# MEMO: 右側に表示させたい場合はこちら
# add-zsh-hook precmd rbenv_version


PROMPT='$(rbenv_version) %{${fg[green]}%}${USER}%{${reset_color}%}:$(current_dir)$(vcs_info_with_color) %{${fg[yellow]}%}$%{${reset_color}%} '


#alias
case "${OSTYPE}" in
freebsd*|darwin*)
  alias ls="ls -GF"
  ;;
linux*)
  alias ls="ls -F --color"
  ;;
esac

alias vimrc='vim ~/.vimrc'
alias tmuxconf='vim ~/.tmux.conf'
alias zshrc='vim ~/.zshrc'
alias dotfiles='~/dotfiles'
alias tailf='tail -f'
alias la='ls -a'
alias ll='ls -l'
alias lla='ls -al'
alias less="less -R"
alias hosts='sudo vi /etc/hosts'
if [[ -x `which colordiff` ]]; then
  # alias diff="colordiff -u --side-by-side --suppress-common-lines"
  alias diff='colordiff -u'
else
  alias diff='diff -u'
fi
# http://orangeclover.hatenablog.com/entry/20110201/1296511181
alias clear2="echo -e '\026\033c'"
alias ag='ag -S'


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
alias gbd='git branch -d'
alias gbm='git branch -m'
alias gc='git commit'
alias gcam='git commit --allow-empty -m'
alias gcamim='git commit --allow-empty -m "Init milestone"'
alias gcamit='git commit --allow-empty -m "Init topic"'
alias gcm='git commit -m'
alias gcmtw='git commit -m "tweak"'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcom='git checkout master'
alias gcop='git checkout -p'
alias gd='git diff'
alias gda='git diff HEAD'
alias gdc='git diff --cached'
alias gf='git fetch'
alias gfu='git fetch upstream'
alias gi='git init'
alias gl='git log'
alias glg='git log --graph --oneline --decorate --all'
alias gld='git log --pretty=format:"%h %ad %s" --date=short --all'
alias gm='git merge --no-ff'
# alias gp='git pull'
alias gps='git push'
alias gs='git status'
alias gss='git status -s'
alias gst='git stash -u'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gstd='git stash drop'
 
# ----------------------
# Git Function
# ----------------------
# Git log find by commit message
function glf() { git log --all --grep="$1"; }


#history setting
HISTFILE="$HOME/.zsh_history"
setopt hist_ignore_dups
setopt share_history
setopt hist_ignore_space
HISTSIZE=1000000
SAVEHIST=1000000

#例えば"ls "とうってからC-pでlsから始まる履歴を検索できます。複数行のコマンドのときはカーソルキーで移動できるようにしています。
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

#cd
setopt auto_cd

#title
precmd() {
 echo -ne "\033]0;${USER}@${HOST}\007"
}

#prompt
autoload colors
colors

#color
export LSCOLORS=gxfxxxxxcxxxxxxxxxgxgx
export LS_COLORS='di=01;36:ln=01;35:ex=01;32'
zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'ex=32'


#補完
autoload -U compinit
compinit -C
#大文字小文字を意識しない補完
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

#LESSのハイライト
export LESS='-R'
export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh %s'

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
add-zsh-hook precmd is_rails_dir

function is_rails_dir () {
  if [ -e './config/environment.rb' ]; then
    add_rails_bin_path_for_binstubs
  fi
}

function add_rails_bin_path_for_binstubs () {
  export PATH=./bin:$PATH
}

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"


#=======================================================
# peco
#=======================================================
function repos() {
  BUFFER="cd $(find ~/workspace -name '*' -type d -follow -maxdepth 5 | egrep -v '\.|app/|/app$|bin|bundle_bin|bower_components|node_modules|config|data|db|doc|dummy|features|lib|log|public|script|spec|sys|test|tmp|vendor' | peco)"
  zle accept-line
  # zle reset-prompt
  zle clear-screen
}
zle -N repos
bindkey '^f' repos

# pecoで表示されるコマンド履歴の重複を削除する 改
# http://shigemk2.hatenablog.com/entry/2015/02/01/peco%E3%81%A7%E8%A1%A8%E7%A4%BA%E3%81%95%E3%82%8C%E3%82%8B%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E5%B1%A5%E6%AD%B4%E3%81%AE%E9%87%8D%E8%A4%87%E3%82%92%E5%89%8A%E9%99%A4%E3%81%99%E3%82%8B_%E6%94%B9
function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(history -n 1 | eval $tac | peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history


#=======================================================
#=======================================================
# if (which zprof > /dev/null) ;then
#   zprof | less
# fi

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
