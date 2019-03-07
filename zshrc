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
