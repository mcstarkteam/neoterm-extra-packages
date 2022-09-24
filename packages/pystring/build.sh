TERMUX_PKG_HOMEPAGE=https://github.com/imageworks/pystring
TERMUX_PKG_DESCRIPTION="C++ functions matching the interface and behavior of python string methods with std::string"
TERMUX_PKG_LICENSE="BSD 3-Clause"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=1.1.3
TERMUX_PKG_REVISION=2
TERMUX_PKG_SRCURL=https://github.com/imageworks/pystring/archive/refs/tags/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=358a56e756e701836b69a31c75d3d9d41c34d447cf7b3775bbd5620dcd3203d9

termux_step_pre_configure() {
	cp $TERMUX_PKG_BUILDER_DIR/CMakeLists.txt $TERMUX_PKG_SRCDIR/
}
