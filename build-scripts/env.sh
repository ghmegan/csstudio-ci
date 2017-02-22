TOP_DIR="$(cd ${SCRIPT_DIR}/.. && pwd)"

CSS_REPO="$SCRIPT_DIR/css_repo"

MSET="${SCRIPT_DIR}/settings.xml"
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
