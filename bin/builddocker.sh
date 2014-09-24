#!/bin/bash

LOG=/tmp/make.log
BASE=/root
VERSION=$(cat $BASE/docker/VERSION)
echo "" > $LOG
pull() {
	exec 3>&1 1>>${LOG} 2>&1
	git clone https://github.com/docker/docker.git $BASE/docker || cd $BASE/docker && git checkout . && git pull
}

master() {
	exec 3>&1 1>>${LOG} 2>&1
	cd $BASE/docker \
	&& git checkout master \
	&& make -w
}

release() {
	cd $BASE/docker \
	&& git checkout release \
	&& make -w
}

deploy() {
	supervisorctl stop docker >> $LOG
	cp -v $BASE/docker/bundles/$VERSION/binary/docker-$VERSION /usr/local/bin/docker >> $LOG
	chmod -v  +x /usr/local/bin/docker >> $LOG
	supervisorctl start docker >> $LOG
}




case "$1" in
	master)
	    pull
	    master
	    ;;
        deploy)
            deploy
            ;;
	release)
	    release
	    ;;
         
         
        *)
            echo $"Usage: $0 {master|release|deploy}"
            exit 1
 
esac
