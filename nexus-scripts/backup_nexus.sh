#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

NEXUS_WORKDIR=/opt/sonatype-work

SYNC_DIR=`pwd`/nexus-backup

INCLUDES_FILE=${SCRIPT_DIR}/includes.list

TAR_FILE=nexus-backup-`date +%F`.tar.gz

#DRY_RUN=-n

mkdir -p ${SYNC_DIR}

rsync -a --delete -v ${DRY_RUN} \
    --include-from ${INCLUDES_FILE} \
    ${NEXUS_WORKDIR} ${SYNC_DIR}

tar cfz ${TAR_FILE} nexus-backup
