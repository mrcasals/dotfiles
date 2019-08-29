source ~/.dotfiles/zsh/env
source ~/.dotfiles/zsh/functions
source ~/.dotfiles/zsh/aliases
source ~/.dotfiles/zsh/config

source ~/.zshrc.local

[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh

export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin

export ANDROID_HOME=~/Library/Android/sdk
export PATH=${PATH}:${ANDROID_HOME}/tools
export PATH=${PATH}:${ANDROID_HOME}/platform-tools

alias rs="bin/rails s"
alias rc="bin/rails c"

###-tns-completion-start-###
if [ -f /Users/marc/.tnsrc ]; then
    source /Users/marc/.tnsrc
fi
###-tns-completion-end-###

fpath=(~/.zsh/completions $fpath)
fpath=(/usr/local/share/zsh/site-functions $fpath)
autoload -U compinit && compinit

# pure prompt
autoload -U promptinit; promptinit
prompt pure

# zsh highlighting for pure prompt
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh

# disable closing window with Ctrl-D
setopt ignore_eof

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Directory autocompletion, from https://superuser.com/a/815317/316001
# 0 -- vanilla completion (abc => abc)
# 1 -- smart case completion (abc => Abc)
# 2 -- word flex completion (abc => A-big-Car)
# 3 -- full flex completion (abc => ABraCadabra)
zstyle ':completion:*' matcher-list '' \
  'm:{a-z\-}={A-Z\_}' \
  'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
  'r:|?=** m:{a-z\-}={A-Z\_}'

##############################################################################
# History Configuration
##############################################################################
HISTSIZE=5000               #How many lines of history to keep in memory
HISTFILE=~/.zsh_history     #Where to save history to disk
SAVEHIST=5000               #Number of history entries to save to disk
#HISTDUP=erase               #Erase duplicates in the history file
setopt    appendhistory     #Append history to the history file (no overwriting)
setopt    sharehistory      #Share history across terminals
setopt incappendhistory     #Immediately append to the history file, not just when a term is killed
# ## History command configuration
# setopt extended_history       # record timestamp of command in HISTFILE
# setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
# setopt hist_ignore_dups       # ignore duplicated commands history list
# setopt hist_ignore_space      # ignore commands that start with space
# setopt hist_verify            # show command with history expansion to user before running it
# setopt inc_append_history     # add commands to HISTFILE in order of execution
# setopt share_history # share command history data
