SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${SCRIPT_DIR}/env.sh

build_path=file:/${CSS_BUILD_DIR}

main_p2_dirs="${build_path}/diirt/p2/target/repository \
    ${build_path}/maven-osgi-bundles/repository/target/repository \
    ${build_path}/cs-studio-thirdparty/repository/target/repository \
    ${build_path}/cs-studio/core/p2repo \
    ${build_path}/cs-studio/applications/p2repo \
    ${build_path}/org.csstudio.display.builder/repository/target/repository"

aux_p2_dirs="${build_path}/archive-influxdb/archive.influxdb-repository/target/repository \
    ${build_path}/influxdb-java/repository/target/repository"


all_p2_dirs=${main_p2_dirs}

if [ "$1" == "--with-aux" ];
then
    all_p2_dirs="${all_p2_dirs} ${aux_p2_dirs}"
fi

all_dir_arr=( $all_p2_dirs )
num_dirs=${#all_dir_arr[@]}


ARTIFACTSF=${CSS_COMP_REPO}/compositeArtifacts.xml
CONTENTF=${CSS_COMP_REPO}/compositeContent.xml
all_xml="${ARTIFACTSF} ${CONTENTF}"


mkdir -p ${CSS_COMP_REPO}

cat >${ARTIFACTSF} <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<?compositeArtifactRepository version='1.0.0'?>
<repository name="Local Composite Repository"
            type="org.eclipse.equinox.internal.p2.artifact.repository.CompositeArtifactRepository"
            version="1.0.0">
EOF

cat >${CONTENTF} <<EOF
<?xml version='1.0' encoding='UTF-8'?>
<?compositeMetadataRepository version='1.0.0'?>
<repository name='Local Composite Repository'
            type='org.eclipse.equinox.internal.p2.metadata.repository.CompositeMetadataRepository'
            version='1.0.0'>
EOF

for xml_file in ${all_xml};
do

    cat >>${xml_file} <<EOF
  <properties size='2'>
    <!-- 'true' will report any error in a child repo.
         Good for asserting that the child locations are valid,
         bad when the child locations already list repositories
         that will only be populated later in the build and are
         initially empty.
     -->
    <property name='p2.atomic.composite.loading' value='false'/>
    <property environment='env'/>
  </properties>
  <children size='${num_dirs}'>
    <!--
        Locations starting in file:/ refer to the root directory,
        everything else is relative to this xml file
    -->
EOF

    for p2_dir in ${all_p2_dirs};
    do
	cat >>${xml_file} <<EOF
    <child location='${p2_dir}' />
EOF
    done

    cat >>${xml_file} <<EOF
  </children>
</repository>
EOF
    
done


