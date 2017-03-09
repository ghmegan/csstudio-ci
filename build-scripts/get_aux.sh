#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${SCRIPT_DIR}/env.sh

GH=https://github.com/

REPOS="ghmegan/archive-influxdb \
ghmegan/influxdb-java"

if [ "$1" == "clean" ]
then
    echo "Cleaning git repos"
    DOCLEAN='git clean -Xdf'
fi

cd $CSS_BUILD_DIR

for i in $REPOS
do
    D=`basename $i`
    if [ -d $D ]
    then
	echo "==== Updating $D ===="
	(cd $D; ${DOCLEAN}; git pull)
    else
	echo "==== Fetching $D ===="
	git clone $GH/$i
	if [ "$D" == "influxdb-java" ]
	then
	    (cd $D; git checkout plugin)
	fi
    fi
done
