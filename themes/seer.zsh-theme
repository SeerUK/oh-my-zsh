# vim:ft=zsh ts=2 sw=2 sts=2
#
# Seer's Theme
# A simple, and elegant theme for readibility and usability.
# Lots of code stolen from agnoster's Theme.
#
# # Goals
#
# The aim of this theme is to only show you what you need to see, in the most
# minimal way possible. It will only show information when it's relevant, and
# it will try to do so with as little wasteful information as possible.

### Segment drawing

CURRENT_BG='NONE'
RETVAL=$?
_newline=$'\n'
_lineup=$'\e[1A'
_linedown=$'\e[1B'

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n "%{$bg%F{$CURRENT_BG}%}%{$fg%}"
  else
    echo -n "%{$bg%}%{$fg%}"
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n "%{%k%F{$CURRENT_BG}%}"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

### Prompt Components

# Context: user at hostname (who am I and where am I)
prompt_context() {
  local user=`whoami`

  prompt_segment NONE magenta "$user"
  prompt_segment NONE white " at"
  prompt_segment NONE yellow " %m"
}

prompt_dir_raw() {
  echo ${(r:1:)${(%):-%~}}$([[ ${(r:1:)${(%):-%~}} != "/" && ${#${(%):-%~}} -gt 1 ]] && echo /)$([[ ${#${(@s:/:)${(%):-%~/a}[2,-1]}} -gt 3 ]] && echo ${(j:/:)${(@r:1:)${(s:/:)${(%):-%~}[2,-1]}[(ws:/:)1,(ws:/:)-3]}}/)$([[ ${#${(@s:/:)${(%):-%~/a}[2,-1]}} -gt 2 ]] && echo ${(@j:/:)${(s:/:)${(%):-%~}[2,-1]}[-2,-1]})$([[ ${#${(@s:/:)${(%):-%~/a}[2,-1]}} -eq 2 ]] && echo ${${(s:/:)${(%):-%~}}[-1]})
}

prompt_dir() {
  prompt_segment NONE white "in"
  prompt_segment NONE green " $(prompt_dir_raw)"
  # prompt_segment NONE green " %~"
}

prompt_status() {
  local symbols
  symbols=()
  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}✘ "
  [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}⚡ "
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}⚙ "

  [[ -n "$symbols" ]] && prompt_segment black default "$symbols"
}

prompt_git() {
  local ref dirty mode repo_path
  repo_path=$(git rev-parse --git-dir 2>/dev/null)

  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    dirty=$(parse_git_dirty)
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git show-ref --head -s --abbrev |head -n1 2> /dev/null)"
    if [[ -n $dirty ]]; then
      prompt_segment NONE yellow
    else
      prompt_segment NONE green
    fi

    if [[ -e "${repo_path}/BISECT_LOG" ]]; then
      mode=" <B>"
    elif [[ -e "${repo_path}/MERGE_HEAD" ]]; then
      mode=" >M<"
    elif [[ -e "${repo_path}/rebase" || -e "${repo_path}/rebase-apply" || -e "${repo_path}/rebase-merge" || -e "${repo_path}/../.dotest" ]]; then
      mode=" >R>"
    fi

    setopt promptsubst
    autoload -Uz vcs_info

    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' get-revision true
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' stagedstr '✚'
    zstyle ':vcs_info:git:*' unstagedstr '●'
    zstyle ':vcs_info:*' formats ' %u%c'
    zstyle ':vcs_info:*' actionformats ' %u%c'
    vcs_info
    echo -n "${ref/refs\/heads\// }${vcs_info_msg_0_%% }${mode}"
  fi
}

PROMPT='
%{%f%b%k%}$(prompt_context) $(prompt_dir)$(prompt_end)
$(prompt_status)$(prompt_end)$ '

RPROMPT='%{${_lineup}%}$(prompt_git)$(prompt_end)%{${_linedown}%}'
