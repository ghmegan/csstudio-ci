SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${SCRIPT_DIR}/env.sh

GH=https://github.com/

REPOS="ControlSystemStudio/diirt \
ControlSystemStudio/maven-osgi-bundles \
ControlSystemStudio/cs-studio-thirdparty \
ControlSystemStudio/cs-studio \
kasemir/org.csstudio.display.builder \
ControlSystemStudio/org.csstudio.sns"

cd $CSS_BUILD_DIR

for i in $REPOS
do
    D=`basename $i`
    if [ -d $D ]
    then
	echo "==== Updating $D ===="
	(cd $D; git clean -Xdf; git pull; git branch)
    else
	echo "==== Fetching $D ===="
	git clone $GH/$i
    fi
done
