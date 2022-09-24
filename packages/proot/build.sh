TERMUX_PKG_HOMEPAGE=https://proot-me.github.io/
TERMUX_PKG_DESCRIPTION="Emulate chroot, bind mount and binfmt_misc for non-root users"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@ATRI"
# Just bump commit and version when needed:
_COMMIT=5c462a6ecfddd629b1439f38fbb61216d6fcb359
TERMUX_PKG_VERSION=5.1.107
TERMUX_PKG_REVISION=54
TERMUX_PKG_SRCURL=https://kgithub.com/termux/proot/archive/${_COMMIT}.zip
TERMUX_PKG_SHA256=2c2a24386587dc852582774169c8f981f043b63630339db0e6046de8ddb876b7
TERMUX_PKG_DEPENDS="libtalloc"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_EXTRA_MAKE_ARGS="-C src"

# Install loader in libexec instead of extracting it every time
export PROOT_UNBUNDLE_LOADER=$TERMUX_PREFIX/libexec/proot

termux_step_pre_configure() {
	CPPFLAGS+=" -DARG_MAX=131072"
}

termux_step_post_make_install() {
	mkdir -p $TERMUX_PREFIX/share/man/man1
	install -m600 $TERMUX_PKG_SRCDIR/doc/proot/man.1 $TERMUX_PREFIX/share/man/man1/proot.1

	sed -e "s|@TERMUX_PREFIX@|$TERMUX_PREFIX|g" \
		$TERMUX_PKG_BUILDER_DIR/neoterm-chroot \
		> $TERMUX_PREFIX/bin/neoterm-chroot
	chmod 700 $TERMUX_PREFIX/bin/neoterm-chroot
}
