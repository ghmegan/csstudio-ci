#!/bin/bash

BUILD_ITEM=$1
#BASE_OPTS="-e -X -s $MSET"
BASE_OPTS="-s $MSET"

echo "Doing build for ${BUILD_ITEM}"

if [ ! -d "$CSS_CI_DIR" ]; then
    echo "CSS_CI_DIR does not exist: $CSS_CI_DIR"
    exit 1
fi

export CSS_COMP_REPO=${CSS_CI_DIR}/css_repo

CSS_WS_LINKS=${CSS_CI_DIR}/css_ws_links

MSET="${CSS_CI_DIR}/csstudio-ci/build-scripts/settings.xml"

if [ ! -r $MSET ]
then
    echo "Missing maven settings"
    exit 1
fi

if [ "$BUILD_ITEM" == "org.csstudio.display.builder" ]
then
    CSS_REPO=file:${CSS_COMP_REPO}
    OPTS="${BASE_OPTS} -Dcss-repo=$CSS_REPO -Dmaven.test.skip=false -DskipTests=false clean verify"
else
    OPTS="${BASE_OPTS} clean verify"
fi

if [ "$BUILD_ITEM" == "cs-studio" ]
then
    cd core
    echo "mvn $OPTS"
    cd ../applications
    echo "mvn $OPTS"
    cd ..
else
    echo "mvn $OPTS"
fi

ln -s $WORKSPACE ${CSS_WS_LINKS}/${BUILD_ITEM}
