#!/bin/bash -x

SNAPSHOT_DIR=/var/www/html/snapshot

cd ${SNAPSHOT_DIR}

SLINKS=`find . -maxdepth 1 -type l`

for slink in "${SLINKS}"
do
    basename=${slink##*/}

    curfile_path=`readlink -f ${slink}`
    curfile_base=${curfile_path##*/}

    shopt -s nullglob
    array=(${basename}_*/)
    shopt -u nullglob # Turn off nullglob to make sure it doesn't interfere with anything later
    echo "${array[@]}" 

    if [ "${#array[@]}" -lt "5" ]; then
	echo "Not deleting any of ${basename}"
    else
	delcount=`expr ${#array[@]} - 4`
	echo "Keeping ${array[@]:$delcount}"
	todelete=${array[@]:0:$delcount}
	echo "Dropping ${todelete}"
	rm -rf ${todelete}
    fi
done
    
