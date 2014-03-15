export GOPATH="$HOME/gocode"
export BREWPATH="/usr/local/sbin:/usr/local/bin"
export CHEFPATH="/opt/chef/bin"
export PYENV_ROOT="$HOME/.pyenv"
export GOENV_ROOT="$HOME/.goenv"
export GOROOT="$GOENV_ROOT/versions/1.2/bin"

export DOCKER_HOST=tcp://localhost:4243

export PATH="$HOME/.bin:$GOPATH/bin:$GOPATH:$GOENV_ROOT/bin:$PYENV_ROOT/bin:$HOME/.rbenv/bin:$BREWPATH:$CHEFPATH:$PATH"

eval "$(rbenv init -)"
eval "$(pyenv init -)"
eval "$(goenv init -)"

eval "$(cat ~/.zsh.theme)"
