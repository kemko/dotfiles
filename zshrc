if [[ ! -o interactive ]] then
  exit 0
fi

export EDITOR=nano
export PATH="$HOME/bin:$PATH"

export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

export DISABLE_CORRECTION=true

setopt append_history
setopt hist_expire_dups_first
setopt hist_fcntl_lock
setopt hist_ignore_all_dups
setopt hist_lex_words
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt share_history

# Prefer US English and use UTF-8
export LANG="en_US"
export LC_ALL="en_US.UTF-8"

COMPLETION_WAITING_DOTS="true"
APPEND_HISTORY="true"

[ -x /usr/bin/grc ] && alias ping="grc --colour=auto ping"
[ -x /usr/bin/atom-beta ] && alias atom=atom-beta

alias ls="ls --color=auto"
alias du="du -hc"
alias df="df -h"
alias nano="nano --backup --nowrap"

for cmd in cp rm chmod chown rename; do
  alias $cmd="$cmd -v"
done

zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

source ~/.zplug/init.zsh

zplug "robbyrussell/oh-my-zsh", use:"lib/*.zsh"
zplug "plugins/git", from:oh-my-zsh, if:"which git"
zplug "plugins/rsync", from:oh-my-zsh, if:"which rsync"
zplug "plugins/tmux", from:oh-my-zsh, if:"which tmux"
zplug "plugins/sublime", from:oh-my-zsh
zplug "plugins/common-aliases", from:oh-my-zsh
zplug "plugins/ubuntu", from:oh-my-zsh
zplug "plugins/command-not-found", from:oh-my-zsh
zplug "plugins/extract", from:oh-my-zsh
zplug "plugins/colorize", from:oh-my-zsh
zplug "plugins/capistrano", from:oh-my-zsh
zplug "plugins/rbenv", from:oh-my-zsh
zplug "plugins/mosh", from:oh-my-zsh
zplug "plugins/httpie", from:oh-my-zsh
zplug "plugins/history", from:oh-my-zsh
zplug "plugins/github", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/docker-compose", from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/bgnotify", from:oh-my-zsh
zplug "plugins/ssh-agent", from:oh-my-zsh
zplug "plugins/gpg-agent", from:oh-my-zsh

zplug "djui/alias-tips"
zplug "so-fancy/diff-so-fancy", as:command

zplug "zsh-users/zsh-history-substring-search", defer:3
zplug "zsh-users/zsh-completions", defer:3
zplug "zsh-users/zsh-syntax-highlighting", defer:3

zplug "themes/tjkirch_mod", from:oh-my-zsh, as:theme

zplug "junegunn/fzf-bin", \
  from:gh-r, \
  as:command, \
  rename-to:fzf, \
  use:"*linux*amd64*"

zplug "github/hub", \
  from:gh-r, \
  as:command, \
  from:gh-r, \
  use:"*linux*amd64*", \
  hook-build:"ln -sf $ZPLUG_HOME/repos/github/hub/hub-linux-amd64-*/etc/{hub.zsh_completion,_hub} && ln -sf $ZPLUG_HOME/repos/github/hub/hub-linux-amd64-*/hub $ZPLUG_HOME/bin"
command -v hub >/dev/null 2>&1 && eval "$(hub alias -s)"

# Install plugins if there are plugins that have not been installed
if ! zplug check; then
  printf "Zplug plugins list has been changed.\nInstall? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

zplug load

compinit

# Disable clock on right side of shell prompt
export RPROMPT=""

if zplug check zsh-users/zsh-autosuggestions; then
  ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(history-substring-search-up history-substring-search-down) # Add history-substring-search-* widgets to list of widgets that clear the autosuggestion
  ZSH_AUTOSUGGEST_CLEAR_WIDGETS=("${(@)ZSH_AUTOSUGGEST_CLEAR_WIDGETS:#(up|down)-line-or-history}") # Remove *-line-or-history widgets from list of widgets that clear the autosuggestion to avoid conflict with history-substring-search-* widgets
fi

# Bind UP and DOWN arrow keys for subsstring search.
if zplug check zsh-users/zsh-history-substring-search; then
  zmodload zsh/terminfo
  bindkey "$terminfo[cuu1]" history-substring-search-up
  bindkey "$terminfo[cud1]" history-substring-search-down
fi

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
