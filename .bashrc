                                                            
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
export PATH="$HOME/bin:$PATH"

export PATH="$HOME/.local/bin:$PATH"
fastfetch
toilet -f mono9 "NightMare" | tte matrix

# Created by `pipx` on 2026-03-22 12:31:07
export PATH="$PATH:/home/nightmare/.local/bin"
