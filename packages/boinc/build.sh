TERMUX_PKG_HOMEPAGE=https://boinc.berkeley.edu/
TERMUX_PKG_DESCRIPTION="Open-source software for volunteer computing"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=7.20.2
TERMUX_PKG_SRCURL=https://github.com/BOINC/boinc/archive/client_release/${TERMUX_PKG_VERSION:0:4}/${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=e577072b06f590d3230c25c94b221dba528b0938681e645bbd870778f8958077
TERMUX_PKG_DEPENDS="libandroid-execinfo, libandroid-shmem, libc++, libcurl, openssl, zlib"
TERMUX_PKG_NO_STATICSPLIT=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-server
--disable-manager
"

# etc/boinc-client.conf is not for Android, extra hooks needed to work
TERMUX_PKG_RM_AFTER_INSTALL="
etc/boinc-client.conf
"

termux_step_pre_configure() {
	# for benchmark purposes
	CFLAGS="${CFLAGS/-Oz/-Os}"
	CXXFLAGS="${CXXFLAGS/-Oz/-Os}"
	CFLAGS+=" -fPIC -DTERMUX_PKG_ANDROID_VERSION=\\\"7.0\\\""
	CXXFLAGS+=" -fPIC -DTERMUX_PKG_ANDROID_VERSION=\\\"7.0\\\""
	LDFLAGS+=" -landroid-shmem -landroid-execinfo $($CC -print-libgcc-file-name)"
	./_autosetup
}

termux_step_post_make_install() {
	install -Dm644 "$TERMUX_PKG_SRCDIR/client/scripts/boinc.bash" "$TERMUX_PREFIX/share/bash-completion/completions/boinc"
}
