source ~/.dotfiles/zsh/env
source ~/.dotfiles/zsh/aliases
source ~/.dotfiles/zsh/config

source ~/.zshrc.local

[ -f $(brew --prefix)/etc/profile.d/autojump.sh ] && . $(brew --prefix)/etc/profile.d/autojump.sh

fpath=(~/.zsh/completions $fpath)
fpath=(/usr/local/share/zsh/site-functions $fpath)
autoload -U compinit && compinit

# asdf
if [[ `uname` = "Linux" ]]; then
  /home/linuxbrew/.linuxbrew/opt/asdf/asdf.sh
  /home/linuxbrew/.linuxbrew/opt/asdf/etc/bash_completion.d/asdf.bash
else
  . /usr/local/opt/asdf/asdf.sh
  . /usr/local/opt/asdf/etc/bash_completion.d/asdf.bash
fi

# starship prompt
eval "$(starship init zsh)"

# zsh highlighting for pure prompt
if [[ `uname` = "Linux" ]]; then
  source /home/linuxbrew/.linuxbrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  source /home/linuxbrew/.linuxbrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh
else
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh
fi

# disable closing window with Ctrl-D
setopt ignore_eof

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

# Avoid "Too many files open" error from fsevent
ulimit -n 8192

# base16 autocompletion
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# Expand history on space
# Eg. `!! ` will automatically get expanded to the last command
#     `!echo ` will get expanded to the last command matching `echo`
#     `!-2 ` will get expanded to the second to last command
bindkey " " magic-space

