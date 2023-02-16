# Handy functions
function mkcd() {
	mkdir -p "$@" && cd "$_";
}
function to(){ 
	touch $1; open $1;
}
function gh() {
    git remote -v | awk '/origin.*push/ {print $2}' | xargs open
}
# Custom prompts 
PROMPT='
%1~ %L %# '
RPROMPT='%*'
# Path to your oh-my-zsh installation.
export ZSH="/Users/josephdespres/.oh-my-zsh"
export VIMCONFIG="~/.dotfiles/config/nvim/init.lua"
# adding syntax highlighting for man pages
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
ZSH_THEME="robbyrussell"
DISABLE_UPDATE_PROMPT="true"

export UPDATE_ZSH_DAYS=13

plugins=(
	git
 	zsh-autosuggestions
	rust
)
source $ZSH/oh-my-zsh.sh
new () {
    sudo touch $1 && open $1
}
# alias
alias lg='lazygit'
alias vim='nvim -n'
alias vi='nvim -n'
alias ls='ls -lAFh --color=tty'

