TERMUX_PKG_HOMEPAGE="no home page"
TERMUX_PKG_DESCRIPTION="Cleaner of ELF files for Android Neoterm"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@atri"
TERMUX_PKG_VERSION=2.1.1
TERMUX_PKG_REVISION=2
TERMUX_PKG_SRCURL=file:///home/$USER/neoterm-packages/opensources/neoterm-elf-cleaner-$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_SHA256=3619d2efc45825613d8eade29066ac9ec79fe02bc67ad739ed185a008e2f50c9 
TERMUX_PKG_DEPENDS="libc++"

termux_step_make_install() {
	# There is no install.sh script in the repository for now
	mkdir -p "$TERMUX_PREFIX/bin"
	install -Dm755 neoterm-elf-cleaner "$TERMUX_PREFIX/bin"
}
