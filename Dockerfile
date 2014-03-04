DOCKER-VERSION 0.8.1


FROM pandrew/ubuntu-current

MAINTAINER Paul Andrew Liljenberg <letters@paulnotcom.se>


# Set HOME for root user
ENV HOME /root
WORKDIR /root
RUN apt-get install -qqy tmux zsh build-essential mercurial libssl-dev zlib1g-dev

RUN chsh -s /usr/bin/zsh

# Install oh-my-zsh
RUN git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# Install goenv
RUN git clone https://github.com/wfarr/goenv.git ~/.goenv

# Install pyenv
RUN git clone https://github.com/yyuu/pyenv.git .pyenv

# Install rbenv
RUN git clone https://github.com/sstephenson/rbenv.git .rbenv


# Install ruby-build
RUN git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

RUN mkdir -p ~/.vim/bundle
RUN git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

RUN mkdir $HOME/gocode
ENV GOPATH $HOME/gocode
ENV PATH $HOME/.goenv/shims:$HOME/.goenv/bin:$GOPATH/bin:$HOME/.pyenv/shims:$HOME/.pyenv/bin:$PATH

RUN echo 'eval "$(goenv init -)"' >  ~/.bash_profile
RUN echo 'eval "$(rbenv init -)"' >  ~/.bash_profile
RUN echo 'eval "$(pyenv init -)"' >  ~/.bash_profile


RUN bash -c 'goenv install 1.2.1 && goenv global 1.2.1'

ADD . /root/.dotfiles
RUN ln -s ~/.dotfiles/zshenv ~/.zshenv
RUN ln -s ~/.dotfiles/zshrc ~/.zshrc
RUN ln -s ~/.dotfiles/zsh.theme ~/.zsh.theme
RUN ln -s ~/.dotfiles/tmux.cof ~/.tmux.conf
RUN ln -s ~/.dotfiles/vimrc ~/.vimrc

RUN ln -s /.dockerinit /usr/local/bin/docker

ENTRYPOINT ["tmux"]
