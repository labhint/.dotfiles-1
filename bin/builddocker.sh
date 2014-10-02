#!/bin/bash

LOG=/tmp/make.log
BASE=/root
VERSION=$(cat $BASE/docker/VERSION)
echo "" > $LOG
pull() {
	git clone https://github.com/docker/docker.git $BASE/docker || cd $BASE/docker && git checkout . && git pull
}

master() {
	cd $BASE/docker \
	&& git checkout master \
	&& make -w
}

release() {
	cd $BASE/docker \
	&& git checkout release \
	&& make -w
}

test() {
        cd $BASE/docker \
        && git checkout master \
        && make -w test
}

deploy() {
	supervisorctl stop docker >> $LOG
	cp -v $BASE/docker/bundles/$VERSION/binary/docker-$VERSION /usr/local/bin/docker >> $LOG
	chmod -v  +x /usr/local/bin/docker >> $LOG
	supervisorctl start docker >> $LOG
}

log() {
	exec 3>&1 1>>${LOG} 2>&1
}


case "$1" in
	master)
	    log
	    pull
	    master
	    ;;
        deploy)
	    log
            deploy
            ;;
	test)
	    pull
	    test
	    ;;
	release)
	    log
	    release
	    ;;
         
         
        *)
            echo $"Usage: $0 {pull|master|release|deploy|test}"
            exit 1
 
esac
