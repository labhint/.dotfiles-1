DOCKER-VERSION 1.0.0
FROM crosbymichael/golang
MAINTAINER Paul Andrew Liljenberg <letters@paulnotcom.se>

# Set HOME for root user
ENV HOME /root
WORKDIR /root
ENV LC_ALL C.UTF-8

RUN apt-get update && apt-get install --no-install-recommends -y \
    curl \
    less \
    openssh-client \
    locales \
    git-core \
    tmux \
    make \
    build-essential \
    mercurial \
    bzr \
    htop \
    vim

RUN dpkg-reconfigure locales && locale-gen C.UTF-8 && /usr/sbin/update-locale LANG=C.UTF-8


RUN mkdir -p ~/.vim/bundle
RUN git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim


ADD . /root/.dotfiles

RUN mkdir ~/.ssh

RUN ln -s ~/.dotfiles/tmux.cof ~/.tmux.conf && \
    ln -s ~/.dotfiles/bash.d ~/.bash.d && \
    ln -fs ~/.dotfiles/bash_profile ~/.bash_profile && \
    ln -fs ~/.dotfiles/bashrc ~/.bashrc && \
    ln -s ~/.dotfiles/vimrc ~/.vimrc && \
    ln -s ~/.dotfiles/gitconfig ~/.gitconfig && \
    ln -s ~/.dotfiles/gitignore ~/.gitignore && \
    ln -s /.dockerinit /usr/local/bin/docker && \
    ln -s /usr/local/go /root/go

RUN bash /root/.dotfiles/go-install.sh

CMD ["tmux"]
