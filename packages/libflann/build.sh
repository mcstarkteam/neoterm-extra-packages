TERMUX_PKG_HOMEPAGE=https://github.com/flann-lib/flann
TERMUX_PKG_DESCRIPTION="A library for performing fast approximate nearest neighbor searches in high dimensional spaces"
TERMUX_PKG_LICENSE="BSD 3-Clause"
TERMUX_PKG_MAINTAINER="@termux"
_COMMIT=1d04523268c388dabf1c0865d69e1b638c8c7d9d
TERMUX_PKG_VERSION=2019.04.06
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://github.com/flann-lib/flann.git
TERMUX_PKG_GIT_BRANCH=master
TERMUX_PKG_DEPENDS="libc++, liblz4"
TERMUX_PKG_BUILD_DEPENDS="libhdf5-static"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_PYTHON_BINDINGS=OFF
-DBUILD_MATLAB_BINDINGS=OFF
-DBUILD_EXAMPLES=OFF
-DBUILD_TESTS=OFF
-DBUILD_DOC=OFF
"

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
