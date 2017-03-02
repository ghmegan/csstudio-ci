#!/bin/bash -x

PREFIX=$1
SOURCE=$2

if [ "x" == "x$PREFIX" ]
then
    echo "Must specify destination prefix as first argument"
    exit 1
fi

if [ ! -e "$SOURCE" ]
then
    echo "Must specify source file or directory as second argument"
    exit 1
fi

SNAPSHOT=/var/www/html/snapshot/$PREFIX
THIS_SNAP=${SNAPSHOT}_`date +'%Y_%m_%d'`

rm -rf $THIS_SNAP
mkdir -p $THIS_SNAP
cp -r $SOURCE $THIS_SNAP/.
rm -f $SNAPSHOT
ln -s $THIS_SNAP $SNAPSHOT
