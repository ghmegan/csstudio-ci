ENVSH_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export CSS_COMP_REPO="$ENVSH_DIR/css_repo"
MSET="${ENVSH_DIR}/settings.xml"

export CSS_BUILD_DIR="$(cd ${ENVSH_DIR}/.. && pwd)/BUILD"

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

SUBFILE=${CSS_COMP_REPO}/compositeArtifacts.template.xml
OUTFILE=${CSS_COMP_REPO}/compositeArtifacts.xml

cat $SUBFILE | sed -e "s?CSS_BUILD_DIR?file:/${CSS_BUILD_DIR}?" > $OUTFILE

SUBFILE=${CSS_COMP_REPO}/compositeContent.template.xml
OUTFILE=${CSS_COMP_REPO}/compositeContent.xml

cat $SUBFILE | sed -e "s?CSS_BUILD_DIR?file:/${CSS_BUILD_DIR}?" > $OUTFILE


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

if [ ! -x "$M2_HOME/bin/mvn" ]
then
    echo "Missing M2_HOME"
    exit 1
fi
