TERMUX_PKG_HOMEPAGE=https://dri.freedesktop.org/wiki/
TERMUX_PKG_DESCRIPTION="Userspace interface to kernel DRM services"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=2.4.110
TERMUX_PKG_SRCURL=https://dri.freedesktop.org/libdrm/libdrm-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=eecee4c4b47ed6d6ce1a9be3d6d92102548ea35e442282216d47d05293cf9737

TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-Dintel=false
-Dradeon=false
-Damdgpu=false
-Dnouveau=false
-Dvmwgfx=false
"

termux_step_pre_configure() {
	CFLAGS="${CFLAGS} -DANDROID"
}

termux_step_install_license() {
	install -Dm600 -t $TERMUX_PREFIX/share/doc/$TERMUX_PKG_NAME \
		$TERMUX_PKG_BUILDER_DIR/LICENSE
}
