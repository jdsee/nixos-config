#!/bin/bash

# JDTLS_HOME="$XDG_CONFIG_HOME/nvim/.language_server/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository"
JDTLS_HOME="$HOME/.local/share/nvim/mason/packages/jdtls"
JDTLS_JAR="$JDTLS_HOME/plugins/org.eclipse.equinox.launcher_*.jar"

java \
	-Declipse.application=org.eclipse.jdt.ls.core.id1 \
	-Dosgi.bundles.defaultStartLevel=4 \
	-Declipse.product=org.eclipse.jdt.ls.core.product \
  -Dlog.protocol=true \
	-Dlog.level=ALL \
	-Xmx1G \
	--add-modules=ALL-SYSTEM \
	--add-opens java.base/java.util=ALL-UNNAMED \
	--add-opens java.base/java.lang=ALL-UNNAMED \
  -javaagent:$XDG_CONFIG_HOME/nvim/dependencies/lombok.jar \
  -Xbootclasspath/a:$XDG_CONFIG_HOME/nvim/dependencies/lombok.jar \
  -jar $JDTLS_JAR \
	-configuration $JDTLS_HOME/config_linux \
	-data "$1"
