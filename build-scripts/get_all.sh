SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${SCRIPT_DIR}/env.sh

GH=https://github.com/

MAIN_REPOS="ControlSystemStudio/diirt \
ControlSystemStudio/maven-osgi-bundles \
ControlSystemStudio/cs-studio-thirdparty \
ControlSystemStudio/cs-studio \
kasemir/org.csstudio.display.builder \
ControlSystemStudio/org.csstudio.sns"

REPOS="${MAIN_REPOS} ${INFLUX_REPOS}"

for arg in "$@"
do
    if [ "$arg" == "--git-clean" ]
    then
	echo "Cleaning git repos"
	DOCLEAN='git clean -Xdf'
    fi
done

cd $CSS_BUILD_DIR

for i in $REPOS
do
    D=`basename $i`
    if [ -d $D ]
    then
	echo "==== Updating $D ===="
	(cd $D; ${DOCLEAN}; git pull; git branch)
    else
	echo "==== Fetching $D ===="
	git clone $GH/$i
    fi

    if [ "$D" == "influxdb-java" ]
    then
	(cd $D; git checkout plugin-p2)
    fi	
done

(cd org.csstudio.sns; git checkout influxdb-product)
(cd cs-studio; git checkout influxdb-archive-app)
