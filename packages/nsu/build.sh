TERMUX_PKG_HOMEPAGE="no home page"
TERMUX_PKG_DESCRIPTION="A su wrapper for Neoterm by atri"
TERMUX_PKG_LICENSE="ISC"
TERMUX_PKG_MAINTAINER="@atri"
TERMUX_PKG_VERSION=8.6.0
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_SHA256=b393d5855b68d45c034bff222e00a6c9d2472a9083eadf6f9e36b8cff4f38d57 
TERMUX_PKG_SRCURL=file:///home/$USER/neoterm-packages/opensources/nsu-$TERMUX_PKG_VERSION.tar.gz

termux_step_make_install() {
	# There is no install.sh script in the repository for now
	mkdir -p "$TERMUX_PREFIX/bin"
	install -Dm755 nsu "$TERMUX_PREFIX/bin"
	# sudo - is an included addon in tsu now
	ln -sf "$TERMUX_PREFIX/bin/nsu" "$TERMUX_PREFIX/bin/sudo"
}
