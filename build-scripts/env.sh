ENVSH_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export CSS_COMP_REPO="$ENVSH_DIR/css_repo"
MSET="${ENVSH_DIR}/settings.xml"

export CSS_BUILD_DIR="$(cd ${ENVSH_DIR}/.. && pwd)/BUILD-OLD"

if [ -z ${CSS_BUILD_DIR+x} ]
then 
    echo "CSS_BUILD_DIR is unset"
    exit 1
else 
    mkdir -p ${CSS_BUILD_DIR}
fi

if [ ! -d "$CSS_BUILD_DIR" ]; then
    echo "Could not create $CSS_BUILD_DIR"
    exit 1
fi

export CSS_M2_LOCAL=${CSS_BUILD_DIR}/dot.m2/repository

echo "Building in ${CSS_BUILD_DIR}"

if [ ! -r $MSET ]
then
    echo "Missing maven settings"
    exit 1
fi

if [ ! -x "$JAVA_HOME/bin/java" ]
then
    echo "Missing JAVA_HOME/bin/java"
    exit 1
fi

if [ ! -x "$M2_HOME" ]
then
    echo "Missing M2_HOME"
    exit 1
fi

export M2_EXE=${M2_HOME}/bin/mvn

if [ ! -x "$M2_EXE" ]
then
    echo "Missing ${M2_HOME}/bin/mvn"
    exit 1
fi
