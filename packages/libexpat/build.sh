TERMUX_PKG_HOMEPAGE=https://libexpat.github.io/
TERMUX_PKG_DESCRIPTION="XML parsing C library"
TERMUX_PKG_LICENSE="BSD"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=2.4.8
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://kgithub.com/libexpat/libexpat/releases/download/R_${TERMUX_PKG_VERSION//./_}/expat-$TERMUX_PKG_VERSION.tar.bz2
TERMUX_PKG_SHA256=a247a7f6bbb21cf2ca81ea4cbb916bfb9717ca523631675f99b3d4a5678dcd16
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_UPDATE_VERSION_REGEXP="\d+.\d+.\d+"
TERMUX_PKG_BREAKS="libexpat-dev"
TERMUX_PKG_REPLACES="libexpat-dev"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--without-xmlwf --without-docbook"


termux_step_post_make_install() {
	sed  -r 's/.[0-9]+(\.[0-9]+)*//' -i $TERMUX_PREFIX/lib/cmake/expat-$TERMUX_PKG_VERSION/expat-noconfig.cmake
}
