TERMUX_PKG_HOMEPAGE="no home page"
TERMUX_PKG_DESCRIPTION="Cleaner of ELF files for Android"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@atri"
TERMUX_PKG_VERSION=2.1.1
TERMUX_PKG_REVISION=2
TERMUX_PKG_SRCURL=https://kgithub.com/termux/termux-elf-cleaner/archive/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=104231f91ef6662f80694fc4a59c6bfeae50da21c4fc22adac3c9a5aac00ba98
TERMUX_PKG_DEPENDS="libc++"

termux_step_pre_configure() {
	autoreconf -vfi

	sed "s%@TERMUX_PKG_API_LEVEL@%$TERMUX_PKG_API_LEVEL%g" \
		"$TERMUX_PKG_BUILDER_DIR"/android-api-level.diff | patch --silent -p1
}
