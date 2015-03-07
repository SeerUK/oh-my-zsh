# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="seer"
DEFAULT_USER="seer"

SCALA_HOME=/opt/scala

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh
source $HOME/git/vendor/zsh-users@github.com/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Customize to your needs...
export PATH=$PATH:/Users/seer/.composer/vendor/bin:/Users/seer/opt/arcanist/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/seer/sdks/android-sdk-linux/platform-tools:/User/seer/sdks/android-sdk-linux/tools:/usr/local/share/python:$SCALA_HOME/bin

setopt no_share_history

export MYSQL_PS1="\u@\h [\d]> "
export TERM="xterm-256color"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export DOCKER_HOST=tcp://192.168.200.2:2375

if [[ `uname` == "Darwin"; ]] then
	alias ls="gls"
fi

alias ll="ls -lhv --group-directories-first --color"
alias vim="mvim -v"

# Git Aliases
alias gs="git status"
alias gco="git checkout"
alias gu="git up"
alias gp="git push"
alias grba="git rebase --abort"
alias grbc="git rebase --continue"
alias gf="git fetch"
alias gcl="git clone"
alias gm="git merge"
alias ga="git add"

alias projtd="cd /Users/seer/git/projects/byng_systems@bitbucket.org/td-trading-app && tmux"
