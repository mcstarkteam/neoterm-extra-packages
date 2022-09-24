TERMUX_PKG_HOMEPAGE="no home page"
TERMUX_PKG_DESCRIPTION="GPG public keys for the official Termux repositories"
TERMUX_PKG_LICENSE="Apache-2.0"
TERMUX_PKG_MAINTAINER="@atri"
TERMUX_PKG_VERSION=4.0
TERMUX_PKG_SKIP_SRC_EXTRACT=true
TERMUX_PKG_PLATFORM_INDEPENDENT=true
TERMUX_PKG_ESSENTIAL=true

termux_step_make_install() {
	if [ "$TERMUX_PACKAGE_FORMAT" = "debian" ]; then
		local GPG_DIR="$TERMUX_PREFIX/etc/apt/trusted.gpg.d"
	else
		local GPG_DIR="$TERMUX_PREFIX/share/pacman/keyrings"
	fi

	mkdir -p $GPG_DIR

	# Maintainer-specific keys.
	install -Dm600 $TERMUX_PKG_BUILDER_DIR/atri.gpg $GPG_DIR

	# Key for automatic builds (via CI).
	install -Dm600 $TERMUX_PKG_BUILDER_DIR/neoterm-autobuilds.gpg $GPG_DIR

	# Creation of trusted files
	if [ "$TERMUX_PACKAGE_FORMAT" = "pacman" ]; then
		install -Dm600 $TERMUX_PKG_BUILDER_DIR/neoterm-pacman.gpg $GPG_DIR
		echo "998DE27318E867EA976BA877389CEED64573DFCA:4:" > $GPG_DIR/termux-pacman-trusted
	fi
}
