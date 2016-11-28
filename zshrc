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
