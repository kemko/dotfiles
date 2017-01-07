export EDITOR=nano
export PATH="$HOME/bin:$PATH"

export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignoredups
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

# Prefer US English and use UTF-8
export LANG="en_US"
export LC_ALL="en_US.UTF-8"

COMPLETION_WAITING_DOTS="true"
APPEND_HISTORY="true"

[ -x /usr/bin/grc ] && alias ping="grc --colour=auto ping"

alias ls="ls --color=auto"
alias du="du -hc"
alias df="df -h"
alias nano="nano --backup --nowrap"

for cmd in cp rm chmod chown rename; do
  alias $cmd="$cmd -v"
done

zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

source ~/.zplug/init.zsh

zplug "plugins/git", from:oh-my-zsh, if:"which git", defer:2
zplug "plugins/rsync", from:oh-my-zsh, if:"which rsync", defer:2
zplug "plugins/tmux", from:oh-my-zsh, if:"which tmux", defer:2
zplug "plugins/sublime", from:oh-my-zsh
zplug "plugins/common-aliases", from:oh-my-zsh, defer:2
zplug "plugins/ubuntu", from:oh-my-zsh
zplug "plugins/command-not-found", from:oh-my-zsh
zplug "plugins/extract", from:oh-my-zsh
zplug "plugins/colorize", from:oh-my-zsh
zplug "plugins/capistrano", from:oh-my-zsh
zplug "plugins/rbenv", from:oh-my-zsh
zplug "plugins/mosh", from:oh-my-zsh
zplug "plugins/httpie", from:oh-my-zsh
zplug "plugins/history", from:oh-my-zsh
zplug "plugins/github", from:oh-my-zsh, defer:2
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/docker-compose", from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/bgnotify", from:oh-my-zsh
zplug "plugins/ssh-agent", from:oh-my-zsh

zplug "knu/z", use:z.sh, defer:2
zplug "rimraf/k", use:k.sh
zplug "zsh-users/zsh-completions", defer:3
zplug "zsh-users/zsh-history-substring-search", defer:3

zplug "themes/tjkirch_mod", from:oh-my-zsh, as:theme

zplug "junegunn/fzf-bin", \
  from:gh-r, \
  as:command, \
  rename-to:fzf, \
  use:"*linux*amd64*"

zplug "github/hub", \
  from:gh-r, \
  as:command, \
  rename-to:hub, \
  use:"*Linux*64-bit*"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

# Then, source plugins and add commands to $PATH
zplug load
