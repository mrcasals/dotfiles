source ~/.dotfiles/zsh/env
source ~/.dotfiles/zsh/functions
source ~/.dotfiles/zsh/aliases
source ~/.dotfiles/zsh/config

source ~/.zshrc.local

[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

export ZSH=/Users/marc/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

export NVM_DIR="/Users/marc/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh
