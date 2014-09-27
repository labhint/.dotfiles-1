FROM ubuntu:14.04
MAINTAINER Paul Andrew Liljenberg <liljenberg.paul@gmail.com>

# Set HOME for root user
ENV HOME /root
WORKDIR /root

ENV LC_ALL C.UTF-8
ENV GOPATH /go
ENV GOROOT /usr/local/go
ENV PATH $PATH:/usr/local/go/bin:/go/bin

RUN apt-get update && apt-get install --no-install-recommends -y \
    curl \
    git-core \
    less \
    ca-certificates \
    ruby-dev \
    mercurial \
    openssh-client \
    locales \
    tmux \
    make \
    build-essential \
    libssl-dev \
    mercurial \
    bzr \
    htop \
    vim


RUN mkdir -p ~/.vim/bundle
RUN git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

RUN curl -s https://storage.googleapis.com/golang/go1.3.2.linux-amd64.tar.gz | tar -v -C /usr/local -xz

RUN git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

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
    ln -s /usr/local/go ~/go

RUN bash /root/.dotfiles/go-install.sh

CMD ["tmux"]
