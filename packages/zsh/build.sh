TERMUX_PKG_HOMEPAGE=https://www.zsh.org
TERMUX_PKG_DESCRIPTION="Shell with lots of features"
TERMUX_PKG_LICENSE="custom"
TERMUX_PKG_LICENSE_FILE="LICENCE"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=5.9
TERMUX_PKG_SRCURL=https://fossies.org/linux/misc/zsh-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=9b8d1ecedd5b5e81fbf1918e876752a7dd948e05c1a0dba10ab863842d45acd5
# Remove hard link to bin/zsh as Android does not support hard links:
TERMUX_PKG_RM_AFTER_INSTALL="bin/zsh-${TERMUX_PKG_VERSION}"
TERMUX_PKG_DEPENDS="libandroid-support, libcap, ncurses, termux-tools, command-not-found, pcre"
TERMUX_PKG_RECOMMENDS="command-not-found, zsh-completions"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-gdbm
--enable-pcre
--enable-cap
--enable-etcdir=$TERMUX_PREFIX/etc
ac_cv_header_utmp_h=no
ac_cv_func_getpwuid=yes
ac_cv_func_setresgid=no
ac_cv_func_setresuid=no
"
TERMUX_PKG_CONFFILES="etc/zshrc"
TERMUX_PKG_BUILD_IN_SRC=true

# Remove compdef pkg not suitable for Termux:
TERMUX_PKG_RM_AFTER_INSTALL+="
share/zsh/${TERMUX_PKG_VERSION}/functions/_pkg5
"

termux_step_post_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $TERMUX_PREFIX.
	if $TERMUX_ON_DEVICE_BUILD; then
		termux_error_exit "Package '$TERMUX_PKG_NAME' is not safe for on-device builds."
	fi

	# INSTALL file: "For a non-dynamic zsh, the default is to compile the complete, compctl, zle,
	# computil, complist, sched, # parameter, zleparameter and rlimits modules into the shell,
	# and you will need to edit config.modules to make any other modules available."
	# Since we build zsh non-dynamically (since dynamic loading doesn't work on Android when enabled),
	# we need to explicitly enable the additional modules we want.
	# - The files module is needed by `compinstall` (https://github.com/termux/termux-packages/issues/61).
	# - The regex module seems to be used by several extensions.
	# - The curses, socket and zprof modules was desired by BrainDamage on IRC (#termux).
	# - The deltochar and mathfunc modules is used by grml-zshrc (https://github.com/termux/termux-packages/issues/494).
	# - The system module is needed by zplug (https://github.com/termux/termux-packages/issues/659).
	# - The zpty module is needed by zsh-async (https://github.com/termux/termux-packages/issues/672).
	# - The stat module is needed by zui (https://github.com/termux/termux-packages/issues/2829).
	# - The mapfile module was requested in https://github.com/termux/termux-packages/issues/3116.
	# - The zselect module is used by multiple plugins (https://github.com/termux/termux-packages/issues/4939)
	# - The param_private module was requested in https://github.com/termux/termux-packages/issues/7391.
	# - The cap module was requested in https://github.com/termux/termux-packages/issues/3102.
	for module in cap curses deltochar files mapfile mathfunc pcre regex \
		socket stat system zprof zpty zselect param_private
	do
		perl -p -i -e "s|${module}.mdd link=no|${module}.mdd link=static|" $TERMUX_PKG_BUILDDIR/config.modules
	done
}

termux_step_post_make_install() {
	# /etc/zshrc - Run for interactive shells (http://zsh.sourceforge.net/Guide/zshguide02.html):
	sed "s|@TERMUX_PREFIX@|$TERMUX_PREFIX|" $TERMUX_PKG_BUILDER_DIR/etc-zshrc > $TERMUX_PREFIX/etc/zshrc

	# Remove zsh.new/zsh.old/zsh-$version if any exists:
	rm -f $TERMUX_PREFIX/{zsh-*,zsh.*}
}
