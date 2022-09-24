TERMUX_PKG_HOMEPAGE=http://caca.zoy.org/wiki/zzuf
TERMUX_PKG_DESCRIPTION="A transparent application input fuzzer"
TERMUX_PKG_LICENSE="WTFPL"
TERMUX_PKG_MAINTAINER="@termux"
_COMMIT=e598eef77a98d77dc6aec6fd2c845e3cd07dc4fd
TERMUX_PKG_VERSION=2019.02.08
TERMUX_PKG_SRCURL=https://github.com/samhocevar/zzuf.git
TERMUX_PKG_GIT_BRANCH=master

termux_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT

	local version="$(git log -1 --format=%cs | sed 's/-/./g')"
	if [ "$version" != "$TERMUX_PKG_VERSION" ]; then
		echo -n "ERROR: The specified version \"$TERMUX_PKG_VERSION\""
		echo " is different from what is expected to be: \"$version\""
		return 1
	fi
}

termux_step_pre_configure() {
	autoreconf -fi

	CPPFLAGS+=" -D__USE_GNU"
}
