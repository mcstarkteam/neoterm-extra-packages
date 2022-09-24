TERMUX_PKG_HOMEPAGE=https://maven.apache.org/
TERMUX_PKG_DESCRIPTION="A Java software project management and comprehension tool"
TERMUX_PKG_LICENSE="Apache-2.0"
TERMUX_PKG_MAINTAINER="@masterjavaofficial"
TERMUX_PKG_VERSION=3.8.6
TERMUX_PKG_SRCURL=https://dlcdn.apache.org/maven/maven-3/${TERMUX_PKG_VERSION}/binaries/apache-maven-${TERMUX_PKG_VERSION}-bin.tar.gz
TERMUX_PKG_SHA256=c7047a48deb626abf26f71ab3643d296db9b1e67f1faa7d988637deac876b5a9
TERMUX_PKG_DEPENDS="libjansi, openjdk-17"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_PLATFORM_INDEPENDENT=true

termux_step_make_install() {
	# Remove starter scripts for Windows
	rm -f bin/*.cmd
	# Remove DLL for Windows
	rm -rf lib/jansi-native/Windows
	ln -sf $TERMUX_PREFIX/lib/libjansi.so lib/jansi-native/
	rm -rf $TERMUX_PREFIX/opt/maven
	mkdir -p $TERMUX_PREFIX/opt
	cp -a $TERMUX_PKG_SRCDIR $TERMUX_PREFIX/opt/maven/
	# Symlink only starter scripts for Linux
	for i in mvn mvnDebug mvnyjp; do
		ln -sfr $TERMUX_PREFIX/opt/maven/bin/$i $TERMUX_PREFIX/bin/$i
	done
}
