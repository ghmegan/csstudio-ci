#!/bin/bash

if [ ! -d "$CSS_CI_DIR" ]; then
    echo "CSS_CI_DIR does not exist: $CSS_CI_DIR"
    exit 1
fi

CSS_MAKE_REPO="${CSS_CI_DIR}/csstudio-ci/build-scripts/make_comp_repo.sh"

if [ ! -f "$CSS_MAKE_REPO" ]; then
    echo "CSS_MAKE_REPO does not exist: $CSS_MAKE_REPO"
    exit 1
fi

rm -rf ${CSS_CI_DIR}/dot.m2

CSS_WS_LINKS=${CSS_CI_DIR}/css_ws_links

mkdir -p ${CSS_WS_LINKS}
rm -rf ${CSS_WS_LINKS}/*

# Inputs to make_comp_repo
export CSS_COMP_REPO=${CSS_CI_DIR}/css_repo
export CSS_BUILD_DIR=${CSS_WS_LINKS}

# generate xml
${CSS_MAKE_REPO} $@

