TERMUX_PKG_HOMEPAGE=https://restic.net/
TERMUX_PKG_DESCRIPTION="Fast, secure, efficient backup program"
TERMUX_PKG_LICENSE="BSD"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="0.14.0"
TERMUX_PKG_SRCURL=https://github.com/restic/restic/archive/v$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=78cdd8994908ebe7923188395734bb3cdc9101477e4163c67e7cc3b8fd3b4bd6
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_SUGGESTS="openssh, rclone, restic-server"

termux_step_make() {
	termux_setup_golang

	export GOPATH=$TERMUX_PKG_BUILDDIR
	mkdir -p "$GOPATH"/src/github.com/restic

	ln -sf "$TERMUX_PKG_SRCDIR" "$GOPATH"/src/github.com/restic/restic
	cd "$GOPATH"/src/github.com/restic/restic

	(
		# Separately building for host so we can generate manpages.
		unset GOOS GOARCH CGO_LDFLAGS
		unset CC CXX CFLAGS CXXFLAGS LDFLAGS
		go build -ldflags "-X 'main.version=${TERMUX_PKG_VERSION}'" ./cmd/...
		./restic generate --man doc/man
		rm -f ./restic
	)

	go build -ldflags "-X 'main.version=${TERMUX_PKG_VERSION}'" ./cmd/...
}

termux_step_make_install() {
	cd "$GOPATH"/src/github.com/restic/restic
	install -Dm700 restic "$TERMUX_PREFIX"/bin/restic
	install -Dm600 -t "$TERMUX_PREFIX/share/man/man1/" doc/man/*.1
}
