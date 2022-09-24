TERMUX_PKG_HOMEPAGE=http://www.graphicsmagick.org/
TERMUX_PKG_DESCRIPTION="Collection of image processing tools"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=1.3.38
TERMUX_PKG_REVISION=1
# Bandwith limited on main ftp site, so it's asked to use sourceforge instead:
TERMUX_PKG_SRCURL=https://downloads.sourceforge.net/project/graphicsmagick/graphicsmagick/${TERMUX_PKG_VERSION}/GraphicsMagick-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=d60cd9db59351d2b9cb19beb443170acaa28f073d13d258f67b3627635e32675
TERMUX_PKG_DEPENDS="libwebp, littlecms, libc++, libtiff, freetype, libjasper, libjpeg-turbo, libpng, libbz2, libxml2, liblzma, zstd, zlib"
TERMUX_PKG_BREAKS="graphicsmagick-dev"
TERMUX_PKG_REPLACES="graphicsmagick++, graphicsmagick-dev"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_ftime=no
--with-fontpath=/system/fonts
--without-x
"
