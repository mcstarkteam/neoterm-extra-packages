TERMUX_PKG_HOMEPAGE=https://github.com/ruediger/VobSub2SRT
TERMUX_PKG_DESCRIPTION="A simple command line program to convert .idx / .sub subtitles into .srt text subtitles by using OCR"
TERMUX_PKG_LICENSE="GPL-3.0, GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux"
_COMMIT=0ba6e25e078a040195d7295e860cc9064bef7c2c
TERMUX_PKG_VERSION=2017.12.18
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://github.com/ruediger/VobSub2SRT.git
TERMUX_PKG_GIT_BRANCH=master
TERMUX_PKG_DEPENDS="libc++, tesseract"
TERMUX_PKG_FORCE_CMAKE=true

# Due to dependency on tesseract:
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
