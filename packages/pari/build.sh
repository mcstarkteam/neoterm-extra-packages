TERMUX_PKG_HOMEPAGE=https://pari.math.u-bordeaux.fr/
TERMUX_PKG_DESCRIPTION="A computer algebra system designed for fast computations in number theory"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=2.13.4
TERMUX_PKG_SRCURL=https://pari.math.u-bordeaux.fr/pub/pari/unix/pari-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=bcde9eceae1592814381c1697cdb7063567b6504201b1be47bb58920f3bce185
TERMUX_PKG_DEPENDS="gzip, libgmp, readline"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--with-gmp=$TERMUX_PREFIX
--with-readline=$TERMUX_PREFIX
"

termux_step_pre_configure() {
	LD="$CC"
	case $TERMUX_ARCH_BITS in
		32) PARI_DOUBLE_FORMAT=1 ;;
		64) PARI_DOUBLE_FORMAT=- ;;
	esac
	export PARI_DOUBLE_FORMAT
}

termux_step_configure() {
	./Configure --prefix=$TERMUX_PREFIX --host=$TERMUX_HOST_PLATFORM \
		$TERMUX_PKG_EXTRA_CONFIGURE_ARGS
	TERMUX_PKG_EXTRA_MAKE_ARGS="-C $(echo O*)"
}
