#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.shell_aliases ]; then
    . ~/.shell_aliases
fi

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Starship and ble.sh initialization
eval "$(starship init bash)"
#source -- ~/.local/share/blesh/ble.sh

# Mise config
#eval "$(/home/emanuel/.local/bin/mise activate bash)"
source -- ~/.local/share/blesh/ble.sh
