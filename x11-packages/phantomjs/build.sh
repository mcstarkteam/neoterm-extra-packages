TERMUX_PKG_HOMEPAGE=https://phantomjs.org/
TERMUX_PKG_DESCRIPTION="A headless WebKit scriptable with JavaScript"
TERMUX_PKG_LICENSE="BSD 3-Clause"
TERMUX_PKG_LICENSE_FILE="LICENSE.BSD"
TERMUX_PKG_MAINTAINER="@termux"
_COMMIT=0a0b0facb16acfbabb7804822ecaf4f4b9dce3d2
TERMUX_PKG_VERSION=2020.07.13
TERMUX_PKG_SRCURL=https://github.com/ariya/phantomjs.git
TERMUX_PKG_GIT_BRANCH=master
TERMUX_PKG_DEPENDS="qt5-qtbase, qt5-qtwebkit"
TERMUX_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools"
TERMUX_PKG_FORCE_CMAKE=true

# qt5-qtwebkit is not available for i686.
TERMUX_PKG_BLACKLISTED_ARCHES="i686"

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
