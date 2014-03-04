# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git docker golang)

source $ZSH/oh-my-zsh.sh
source $HOME/.zshenv

# Alias
alias gitdiff-1="git log --reverse|grep commit|cut -d ' ' -f2|tail -n 2|head -n 2|xargs echo|sed -e 's/\s/../'|xargs -n 1 git diff"
alias gitdiff-2="git log --reverse|grep commit|cut -d ' ' -f2|tail -n 3|head -n 2|xargs echo|sed -e 's/\s/../'|xargs -n 1 git diff"
alias gitdiff-3="git log --reverse|grep commit|cut -d ' ' -f2|tail -n 4|head -n 2|xargs echo|sed -e 's/\s/../'|xargs -n 1 git diff"

alias gitlog-1="git log --reverse|grep commit|cut -d ' ' -f2|tail -n 2|head -n 2|xargs echo|sed -e 's/\s/../'|xargs -n 1 git log --summary"
alias gitlog-2="git log --reverse|grep commit|cut -d ' ' -f2|tail -n 3|head -n 2|xargs echo|sed -e 's/\s/../'|xargs -n 1 git log --summary"
alias gitlog-3="git log --reverse|grep commit|cut -d ' ' -f2|tail -n 4|head -n 2|xargs echo|sed -e 's/\s/../'|xargs -n 1 git log --summary"

alias less='less -N'
alias screen='tmux'
#colored cat
alias pcat='pygmentize'

#colored less
function pless() {
    pcat "$1" | less -R
}
#colored diff
function pdiff() {
  diff -u "$1" "$2" | pygmentize -l diff
}


alias sve="setxkbmap se"
alias svo="setxkbmap svorak || setxkbmap se dvorak"

