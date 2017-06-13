#!/bin/bash -x

BUILD_ITEM=$1
echo "Doing build for ${BUILD_ITEM} in ${WORKSPACE}"

if [ ! -d "$M2" ]; then
    echo "Maven bin dir does not exist: $M2"
    exit 1
fi
PATH=$M2:$PATH

if [ ! -d "$CSS_CI_DIR" ]; then
    echo "CSS_CI_DIR does not exist: $CSS_CI_DIR"
    exit 1
fi

export CSS_COMP_REPO=${CSS_CI_DIR}/css_repo
CSS_WS_LINKS=${CSS_CI_DIR}/css_ws_links

MSET="${CSS_CI_DIR}/csstudio-ci/build-scripts/settings.xml"
export CSS_M2_LOCAL=${CSS_CI_DIR}/dot.m2/repository

if [ ! -r $MSET ]
then
    echo "Missing maven settings: ${MSET}"
    exit 1
fi


#BASE_OPTS="-e -X -s $MSET"
BASE_OPTS="-s $MSET --batch-mode"

if [ "$BUILD_ITEM" == "org.csstudio.display.builder" ]
then
    CSS_REPO=file:${CSS_COMP_REPO}
    OPTS="${BASE_OPTS} -Dcss_repo=$CSS_REPO -Dmaven.test.skip=false -DskipTests=false clean verify"
else
    OPTS="${BASE_OPTS} clean verify"
fi

rm -f ${CSS_WS_LINKS}/${BUILD_ITEM}
ln -s $WORKSPACE ${CSS_WS_LINKS}/${BUILD_ITEM}

git clean -Xdf

if [ "$BUILD_ITEM" == "cs-studio" ]
then
    cd core
    mvn $OPTS || exit 1
    cd ../applications
    mvn $OPTS || exit 1
    cd ..
else
    mvn $OPTS || exit 1
fi


