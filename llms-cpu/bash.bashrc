# Do not print anything if this is not being used interactively
[ -z "$PS1" ] && return

# Set up attractive prompt
export PS1="\[\e[36m\]llms-cpu\[\e[m\] \[\e[33m\]\w\[\e[m\] > "
export TERM=xterm-256color
alias grep="grep --color=auto"
alias ls="ls --color=auto"

source /usr/local/bin/motd.sh
