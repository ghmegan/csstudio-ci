#!/bin/bash -x

PREFIX=$1

if [ "x" == "x$PREFIX" ]
then
    echo "Must specify destination prefix as first argument"
    exit 1
fi

SNAPSHOT=/var/www/html/snapshot/$PREFIX
THIS_SNAP=${SNAPSHOT}_`date +'%Y_%m_%d'`

rm -rf $THIS_SNAP
mkdir -p $THIS_SNAP

shift
while (($#)); do
  SOURCE=$1

  if [ ! -e "$SOURCE" ]
  then
    echo "Invalid source file or dir: ${SOURCE}"
    exit 1
  fi

  cp -r $SOURCE $THIS_SNAP/.
  shift
done

rm -f $SNAPSHOT
ln -s $THIS_SNAP $SNAPSHOT
