### Assumes
# Oracle java is installed
# JAVA_HOME is set and java is in the default path
# Maven is installed and on the default path, M2 and M2_HOME are set

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${SCRIPT_DIR}/env.sh

set -x

function build_in {
    result=1

    if [ -z $3 ]; then
	fname=$2_$1
    else
	fname=$2_$3
    fi

    rm -f $fname
    
    (cd "$1"; time mvn $OPTS) | tee $fname.log
    if [ ${PIPESTATUS[0]} -ne 0 ]; then
	echo "$1 build failed"
	exit
    fi
}

cd $CSS_BUILD_DIR

#rm -rf *.log

export MAVEN_OPTS="-Xmx2048m -XX:MaxPermSize=2024m -XX:-UseGCOverheadLimit"
#BASE_OPTS="-e -X -s $MSET"
BASE_OPTS="-s $MSET"
OPTS="${BASE_OPTS} clean verify"

build_in diirt 0

build_in maven-osgi-bundles 1

build_in cs-studio-thirdparty 2

build_in cs-studio/core 3 core

build_in cs-studio/applications 4 applications

CSS_REPO=file:${CSS_COMP_REPO}
OPTS="${BASE_OPTS} -Dcss-repo=$CSS_REPO clean verify"
build_in org.csstudio.display.builder 5 display_builder

OPTS="${BASE_OPTS} clean verify"
build_in org.csstudio.sns 6 sns

ln -s ${CSS_BUILD_DIR}/org.csstudio.sns/repository/target/repository/plugins ${CSS_BUILD_DIR}/sns_plugins
