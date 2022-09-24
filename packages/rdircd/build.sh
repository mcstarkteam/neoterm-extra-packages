TERMUX_PKG_HOMEPAGE=https://github.com/mk-fg/reliable-discord-client-irc-daemon
TERMUX_PKG_DESCRIPTION="A daemon that allows using a personal Discord account through an IRC client"
TERMUX_PKG_LICENSE="WTFPL"
TERMUX_PKG_MAINTAINER="@termux"
_COMMIT=41af6d2b4fe67cd4227b5ac66fc4727e77cee433
TERMUX_PKG_VERSION=2022.03.19
TERMUX_PKG_SRCURL=https://github.com/mk-fg/reliable-discord-client-irc-daemon.git
TERMUX_PKG_GIT_BRANCH=master
TERMUX_PKG_DEPENDS="python"
_PKG_PYTHON_DEPENDS="aiohttp"
TERMUX_PKG_PLATFORM_INDEPENDENT=true
TERMUX_PKG_BUILD_IN_SRC=true

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

termux_step_make_install() {
	install -Dm700 -t $TERMUX_PREFIX/bin rdircd
}

termux_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$TERMUX_PREFIX/bin/sh
	echo "Installing dependencies through pip..."
	pip3 install ${_PKG_PYTHON_DEPENDS}
	EOF
}
