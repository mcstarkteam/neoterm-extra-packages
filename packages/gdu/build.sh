TERMUX_PKG_HOMEPAGE=https://github.com/dundee/gdu
TERMUX_PKG_DESCRIPTION="Modern and intuitive terminal-based text editor"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="5.17.1"
TERMUX_PKG_SRCURL=https://github.com/dundee/gdu/archive/v$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=1b37383e0054e059b02f71b3b5f216c19044f64432b5c5e59d62b361c12c9ad3
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_make() {
	return
}

termux_step_make_install() {
	termux_setup_golang

	make build
	install -D dist/gdu -t $TERMUX_PREFIX/bin
	make gdu.1
	install -Dm644 gdu.1 -t $TERMUX_PREFIX/share/man/man1
}
