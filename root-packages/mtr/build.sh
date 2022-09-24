TERMUX_PKG_HOMEPAGE=https://github.com/traviscross/mtr
TERMUX_PKG_DESCRIPTION="Network diagnostic tool"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux"
_COMMIT=ec42ba61f77654e8397e6496095634585f90b26d
TERMUX_PKG_VERSION=0.94.git.${_COMMIT:0:8}
TERMUX_PKG_SRCURL=https://github.com/traviscross/mtr/archive/${_COMMIT}.tar.gz
TERMUX_PKG_SHA256=69fe865168784275ba20b2230969907dd4df165b13234edfe1c91004b86197c3
TERMUX_PKG_DEPENDS="ncurses"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--without-gtk"

termux_step_pre_configure() {
	cp ${TERMUX_PKG_BUILDER_DIR}/hsearch/* ${TERMUX_PKG_SRCDIR}/portability

	cd ${TERMUX_PKG_SRCDIR}
	./bootstrap.sh
}
