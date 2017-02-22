PLUGIN_DIR=/opt/sonatype-work/nexus/plugin-repository

USER=nexusr
GROUP=nexusr
 
## 2.14.2 plugins

P2_PLUGIN=nexus-p2-repository-plugin-2.14.2-01

P2_PLUGIN_URL="https://repo1.maven.org/maven2/org/sonatype/nexus/plugins/nexus-p2-repository-plugin/2.14.2-01/nexus-p2-repository-plugin-2.14.2-01-bundle.zip"

P2_BRIDGE=nexus-p2-bridge-plugin-2.14.2-01

P2_BRIDGE_URL="https://repo1.maven.org/maven2/org/sonatype/nexus/plugins/nexus-p2-bridge-plugin/2.14.2-01/nexus-p2-bridge-plugin-2.14.2-01-bundle.zip"

## 2.14.3 plugins

#P2_PLUGIN=nexus-p2-repository-plugin-2.14.3-02

#P2_PLUGIN_URL="https://repo1.maven.org/maven2/org/sonatype/nexus/plugins/nexus-p2-repository-plugin/2.14.3-02/nexus-p2-repository-plugin-2.14.3-02-bundle.zip"

#P2_BRIDGE=nexus-p2-bridge-plugin-2.14.3-02

#P2_BRIDGE_URL="https://repo1.maven.org/maven2/org/sonatype/nexus/plugins/nexus-p2-bridge-plugin/2.14.3-02/nexus-p2-bridge-plugin-2.14.3-02-bundle.zip"

cd $PLUGIN_DIR

wget $P2_PLUGIN_URL

unzip ${P2_PLUGIN}-bundle.zip
rm ${P2_PLUGIN}-bundle.zip

chmod -R og-w ${P2_PLUGIN}

wget $P2_BRIDGE_URL

unzip ${P2_BRIDGE}-bundle.zip
rm ${P2_BRIDGE}-bundle.zip

chmod -R og-w ${P2_BRIDGE}

chown -R ${USER}:${GROUP} ./*

