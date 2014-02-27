DOCKER-VERSION 0.8.1


FROM pandrew/ubuntu-current

MAINTAINER Paul Andrew Liljenberg <letters@paulnotcom.se>

RUN apt-get -qqy install mercurial

# Set HOME for root user
ENV HOME /root
WORKDIR /root
RUN apt-get install -qqy build-essential libssl-dev zlib1g-dev

# Install goenv
RUN git clone https://github.com/wfarr/goenv.git ~/.goenv

# Install pyenv
RUN git clone https://github.com/yyuu/pyenv.git .pyenv

RUN mkdir $HOME/gocode
ENV GOPATH $HOME/gocode
ENV PATH $HOME/.goenv/shims:$HOME/.goenv/bin:$GOPATH/bin:$HOME/.pyenv/shims:$HOME/.pyenv/bin:$PATH

RUN echo 'eval "$(goenv init -)"' >  ~/.bash_profile
RUN bash -c 'goenv install 1.2 && goenv global 1.2'


RUN echo 'eval "$(pyenv init -)"' >  ~/.bash_profile

RUN ln -s /.dockerinit /usr/local/bin/docker
