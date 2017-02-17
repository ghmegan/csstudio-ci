### Assumes
# Oracle java is installed
# JAVA_HOME is set and java is in the default path
# Maven is installed and on the default path, M2 and M2_HOME are set

export SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
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

cd $TOP_DIR

#rm -rf *.log

OPTS="-s $MSET clean verify"

#build_in diirt 0

#build_in maven-osgi-bundles 1

#build_in cs-studio-thirdparty 2

#build_in cs-studio/core 3 core

build_in cs-studio/applications 4 applications

CSS_REPO=file:$TOP/org.csstudio.sns/css_repo
OPTS="-s $MSET -Dcss-repo=$CSS_REPO clean verify"
#build_in org.csstudio.display.builder 5 display_builder

OPTS="-s $MSET clean verify"
#build_in org.csstudio.sns 6 sns
