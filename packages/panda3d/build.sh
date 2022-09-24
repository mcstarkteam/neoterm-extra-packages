TERMUX_PKG_HOMEPAGE=https://www.panda3d.org/
TERMUX_PKG_DESCRIPTION="A framework for 3D rendering and game development for Python and C++ programs"
TERMUX_PKG_LICENSE="BSD 3-Clause"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=1.10.11
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://github.com/panda3d/panda3d/archive/refs/tags/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=192b95135f91a1db493a839f9438207c8b51d2209d3a1d3b5f050c39931c4cd8
TERMUX_PKG_DEPENDS="libc++, python"
TERMUX_PKG_BUILD_DEPENDS="libandroid-glob"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_pre_configure() {
	_PYTHON_VERSION=$(. $TERMUX_SCRIPTDIR/packages/python/build.sh; echo $_MAJOR_VERSION)
	termux_setup_python_crossenv
	pushd $TERMUX_PYTHON_CROSSENV_SRCDIR
	_CROSSENV_PREFIX=$TERMUX_PKG_BUILDDIR/python-crossenv-prefix
	python${_PYTHON_VERSION} -m crossenv \
		$TERMUX_PREFIX/bin/python${_PYTHON_VERSION} \
		${_CROSSENV_PREFIX}
	popd
	. ${_CROSSENV_PREFIX}/bin/activate

	CFLAGS+=" $CPPFLAGS"
	CXXFLAGS+=" $CPPFLAGS"
	LDFLAGS+=" -Wl,-rpath=$TERMUX_PREFIX/lib/panda3d"
}

termux_step_make() {
	python makepanda/makepanda.py --nothing
}

termux_step_make_install() {
	python makepanda/installpanda.py --prefix $TERMUX_PREFIX
}
