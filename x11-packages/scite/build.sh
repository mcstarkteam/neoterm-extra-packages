TERMUX_PKG_HOMEPAGE=https://www.scintilla.org/SciTE.html
TERMUX_PKG_DESCRIPTION="A free source code editor"
# License: HPND
TERMUX_PKG_LICENSE="custom"
TERMUX_PKG_LICENSE_FILE="scite/License.txt"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="5.3.0"
TERMUX_PKG_SRCURL=https://www.scintilla.org/scite${TERMUX_PKG_VERSION//./}.tgz
TERMUX_PKG_SHA256=32890add647faf2e1e57dc40006609e3580e27c43f20f6053b1b1c07b080a0a5
TERMUX_PKG_DEPENDS="atk, gdk-pixbuf, glib, gtk3, libc++, libcairo, pango"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_EXTRA_MAKE_ARGS="
CLANG=1
GTK3=1
NO_LUA=1
"

TERMUX_PKG_AUTO_UPDATE=true

termux_extract_src_archive() {
	local file="$TERMUX_PKG_CACHEDIR/$(basename "${TERMUX_PKG_SRCURL}")"
	mkdir -p "$TERMUX_PKG_SRCDIR"
	tar xf "$file" -C "$TERMUX_PKG_SRCDIR" --strip-components=0
}

termux_step_make() {
	local d
	for d in lexilla/src scintilla/gtk scite/gtk; do
		make -j ${TERMUX_MAKE_PROCESSES} -C ${d} \
			${TERMUX_PKG_EXTRA_MAKE_ARGS}
	done
}

termux_step_make_install() {
	make -j ${TERMUX_MAKE_PROCESSES} -C scite/gtk install \
		${TERMUX_PKG_EXTRA_MAKE_ARGS}
}
