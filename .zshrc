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
export ZSH="$HOME/.oh-my-zsh"
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
alias ls='exa -lhmr --icons --sort=mod --time-style=long-iso --git --no-user --no-permissions  --colour-scale  --tree --level=1'
alias lss='exa -lhmr --icons --sort=mod --time-style=long-iso --git --no-user --no-permissions  --colour-scale  --tree --level=2'
alias lsss='exa -lhmr --icons --sort=mod --time-style=long-iso --git --no-user --no-permissions  --colour-scale  --tree --level=3'
alias vim='nvim -n'
alias vi='nvim -n'
alias cat='bat'

alias dotfiles='cd ~/.dotfiles'
alias .dotfiles='cd ~/.dotfiles'

