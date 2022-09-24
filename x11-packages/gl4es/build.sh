TERMUX_PKG_HOMEPAGE=https://ptitseb.github.io/gl4es/
TERMUX_PKG_DESCRIPTION="OpenGL driver for GLES devices"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux"
_COMMIT=b5d41a63e654804b79605b4ec21bafbb3bf4f442
_COMMIT_DATE=20220913
_COMMIT_TIME=080622
TERMUX_PKG_VERSION="1.1.4.20220913.080622gb5d41a63"
TERMUX_PKG_SRCURL=https://github.com/ptitSeb/gl4es.git
TERMUX_PKG_GIT_BRANCH=master
TERMUX_PKG_DEPENDS="libx11"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DTERMUX=ON
-DCMAKE_SYSTEM_NAME=Linux
"

# this should only be used until release new version
termux_pkg_auto_update() {
	local latest_commit latest_commit_date_tz latest_commit_date latest_commit_time latest_version
	latest_commit=$(curl -s https://api.github.com/repos/ptitSeb/gl4es/commits | jq .[].sha | head -1 | sed -e 's|\"||g')

	if [ -z "$latest_commit" ]; then
		termux_error_exit "ERROR: Unable to get latest commit from upstream"
	fi

	if [ "$latest_commit" = "$_COMMIT" ]; then
		echo "INFO: No update needed. Already at version '$TERMUX_PKG_VERSION'."
		return 0
	fi

	latest_commit_date_tz=$(curl -s "https://api.github.com/repos/ptitSeb/gl4es/commits/$latest_commit" | jq .commit.committer.date | sed -e 's|\"||g')

	if [ -z "$latest_commit_date_tz" ]; then
		termux_error_exit "ERROR: Unable to get latest commit date info"
	fi

	latest_commit_date=$(echo "$latest_commit_date_tz" | sed -e 's|\(.*\)T\(.*\)Z|\1|' -e 's|\-||g')
	latest_commit_time=$(echo "$latest_commit_date_tz" | sed -e 's|\(.*\)T\(.*\)Z|\2|' -e 's|\:||g')

	# always check this in case upstream change the version format
	latest_version="1.1.4.${latest_commit_date}.${latest_commit_time}g${latest_commit:0:8}"

	if ! dpkg --compare-versions "$latest_version" gt "$TERMUX_PKG_VERSION"; then
		termux_error_exit "ERROR: Resulting latest version is not counted as update to the current version ($latest_version < $TERMUX_PKG_VERSION)"
	fi

	# unlikely to happen
	if [ "$latest_commit_date" -lt "$_COMMIT_DATE" ]; then
		termux_error_exit "ERROR: Upstream is older than current package version. Please report to upstream."
	elif [ "$latest_commit_date" -eq "$_COMMIT_DATE" ] && [ "$latest_commit_time" -lt "$_COMMIT_TIME" ]; then
		termux_error_exit "ERROR: Upstream is older than current package version. Please report to upstream."
	fi

	sed -i "${TERMUX_PKG_BUILDER_DIR}/build.sh" -e "s|^_COMMIT=.*|_COMMIT=${latest_commit}|"
	sed -i "${TERMUX_PKG_BUILDER_DIR}/build.sh" -e "s|^_COMMIT_DATE=.*|_COMMIT_DATE=${latest_commit_date}|"
	sed -i "${TERMUX_PKG_BUILDER_DIR}/build.sh" -e "s|^_COMMIT_TIME=.*|_COMMIT_TIME=${latest_commit_time}|"

	# maybe save a few ms as we already done version check
	termux_pkg_upgrade_version "$latest_version" --skip-version-check
}

termux_step_post_get_source() {
	git fetch --unshallow
	git reset --hard $_COMMIT
}

termux_step_pre_configure() {
	# dont use flto to avoid linking issue
	# benchmark result as follows:
	# -O2 -flto > -O3 -flto > -O2 > -Os > -Os -flto > -O3 > -Oz > -Oz -flto
	export CFLAGS="${CFLAGS/-Oz/-O2}"
}

termux_step_post_make_install() {
	ln -fsT "libGL.so.1" "$TERMUX_PREFIX/lib/gl4es/libGL.so"
}
