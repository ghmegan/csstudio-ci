#!/bin/bash

if [ ! -d "$CSS_CI_DIR" ]; then
    echo "CSS_CI_DIR does not exist: $CSS_CI_DIR"
    exit 1
fi

CSS_CI_REPO="${CSS_CI_DIR}/csstudio-ci/build-scripts/css_repo"

if [ ! -d "$CSS_CI_REPO" ]; then
    echo "CSS_CI_REPO does not exist: $CSS_CI_REPO"
    exit 1
fi

CSS_HUDSON_REPO=${CSS_CI_DIR}/css_repo
CSS_WS_LINKS=${CSS_CI_DIR}/css_ws_links

mkdir -p ${CSS_HUDSON_REPO}
rm -rf ${CSS_HUDSON_REPO}/*

mkdir -p ${CSS_WS_LINKS}
rm -rf ${CSS_WS_LINKS}/*

SUBFILE=${CSS_CI_REPO}/compositeArtifacts.template.xml
OUTFILE=${CSS_HUDSON_REPO}/compositeArtifacts.xml

cat $SUBFILE | sed -e "s?CSS_BUILD_DIR?file:/${CSS_WS_LINKS}?" > $OUTFILE

SUBFILE=${CSS_CI_REPO}/compositeContent.template.xml
OUTFILE=${CSS_HUDSON_REPO}/compositeContent.xml

cat $SUBFILE | sed -e "s?CSS_BUILD_DIR?file:/${CSS_WS_LINKS}?" > $OUTFILE
