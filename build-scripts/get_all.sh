SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${SCRIPT_DIR}/env.sh

GH=https://github.com/

MAIN_REPOS="ControlSystemStudio/diirt \
ControlSystemStudio/maven-osgi-bundles \
ControlSystemStudio/cs-studio-thirdparty \
ControlSystemStudio/cs-studio \
kasemir/org.csstudio.display.builder \
ControlSystemStudio/org.csstudio.sns"

INFLUX_REPOS="ghmegan/archive-influxdb \
ghmegan/influxdb-java"

REPOS=${MAIN_REPOS}

SNS_INFLUXDB="N"

for arg in "$@"
do
    if [ "$arg" == "--with-influxdb" ]
    then
	REPOS="${REPOS} ${INFLUX_REPOS}"
	SNS_INFLUXDB="Y"
    elif [ "$arg" == "--git-clean" ]
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
	(cd $D; git checkout plugin)
    fi	
done

if [ "${SNS_INFLUXDB}" == "Y" ]
then
    (cd org.csstudio.sns; git checkout influxdb-product)
fi
