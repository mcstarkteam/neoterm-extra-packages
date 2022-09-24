TERMUX_PKG_HOMEPAGE=http://www.openjpeg.org/
TERMUX_PKG_DESCRIPTION="JPEG 2000 image compression library"
TERMUX_PKG_LICENSE="BSD 2-Clause"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="2.5.0"
TERMUX_PKG_SRCURL=https://github.com/uclouvain/openjpeg/archive/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=0333806d6adecc6f7a91243b2b839ff4d2053823634d4f6ed7a59bc87409122a
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_BREAKS="openjpeg-dev"
TERMUX_PKG_REPLACES="openjpeg-dev"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="-DBUILD_STATIC_LIBS=OFF"
# for fast building packages that depend on openjpeg with cmake

termux_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $TERMUX_PREFIX.
	if $TERMUX_ON_DEVICE_BUILD; then
		termux_error_exit "Package '$TERMUX_PKG_NAME' is not safe for on-device builds."
	fi

	# Force symlinks to be overwritten:
	rm -Rf $TERMUX_PREFIX/lib/libopenjp2.so*
}
