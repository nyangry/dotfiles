export MANPATH=/opt/local/share/man:/opt/local/man:$MANPATH
PATH=/usr/local/bin:/usr/local/share/npm/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
#export PATH
export NODE_PATH=/usr/local/share/npm/lib/node_modules:$NODE_PATH

source /Users/masuyama/work/mbook/sys/var/jobroot/conf/global.conf

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
PROMPT='%{${fg[green]}%}${USER}%{${reset_color}%}:$(current_dir)$(vcs_info_with_color) %{${fg[yellow]}%}$%{${reset_color}%} '


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
alias tailf='tail -f'
alias la='ls -a'
alias ll='ls -l'
alias lla='ls -al'
alias less="less -R"
alias hosts='sudo vi /etc/hosts'
alias diff="colordiff --side-by-side --suppress-common-lines"
alias sc='screen'
alias gts='git status'
alias gtl="git log --color --pretty=format:'%h (%cr) %s [%cn]'"
function octiso() {
  bundle exec rake isolate\[$1\]
}
alias ag='ag -S'

function scx () {
    screen -x $1
}

#history setting
HISTFILE="$HOME/.zsh_history"
setopt hist_ignore_dups
setopt share_history
setopt hist_ignore_space
HISTSIZE=100000
SAVEHIST=100000

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
compinit
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

#=============================
# for Google API
#=============================
export GOOGLE_ANALYTICS_PROFILE="ga:36122922"
export GOOGLE_API_HOME="${HOME}/.google-api.yaml"

#=============================
# rbenv
#=============================
if [ -d ${HOME}/.rbenv  ] ; then
  export PATH=${HOME}/.rbenv/bin:${PATH}
  # export PATH
  eval "$(rbenv init -)"
fi
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
  PATH=./bin:$PATH
}

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

#============================
# performance config
# https://gist.github.com/lunchub/6492592
#============================
# export RUBY_GC_MALLOC_LIMIT=60000000
# export RUBY_FREE_MIN=200000
