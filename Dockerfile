DOCKER-VERSION 1.0.0
FROM crosbymichael/golang
MAINTAINER Paul Andrew Liljenberg <letters@paulnotcom.se>

ENV DEBIAN_FRONTEND noninteractive


# Set HOME for root user
ENV HOME /root
WORKDIR /root
ENV LC_ALL C.UTF-8

RUN apt-get update && apt-get install --no-install-recommends -y \
    curl \
    less \
    locales \
    libncurses5-dev \
    git-core \
    tmux \
    make \
    build-essential \
    mercurial \
    libssl-dev \
    zlib1g-dev \
    bzr \
    htop \
    vim

RUN dpkg-reconfigure locales && locale-gen C.UTF-8 && /usr/sbin/update-locale LANG=C.UTF-8


RUN curl -fsL -O http://fishshell.com/files/2.1.0/fish-2.1.0.tar.gz && tar -zxf fish-2.1.0.tar.gz &&\
	cd fish-2.1.0/ && ./configure --prefix=/usr/local && make && make install &&\
	echo '/usr/local/bin/fish' | tee -a /etc/shells && chsh -s /usr/local/bin/fish &&\
	cd && rm -rf fish-2.1.0 && rm fish-2.1.0.tar.gz

RUN mkdir -p ~/.vim/bundle
RUN git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim


ADD . /root/.dotfiles

RUN	ln -s ~/.dotfiles/tmux.cof ~/.tmux.conf && \
	mkdir -p /root/.config/fish && ln -s /root/.dotfiles/config.fish /root/.config/fish/config.fish && \
	ln -s ~/.dotfiles/vimrc ~/.vimrc && \
	ln -s ~/.dotfiles/gitconfig ~/.gitconfig && \
	ln -s ~/.dotfiles/gitignore ~/.gitignore && \
	ln -s /.dockerinit /usr/local/bin/docker && \
	ln -s /usr/local/go /root/go

RUN bash /root/.dotfiles/go-install.sh

CMD ["tmux"]
