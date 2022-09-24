TERMUX_PKG_HOMEPAGE=https://libmateweather.mate-desktop.dev/
TERMUX_PKG_DESCRIPTION="libmateweather is a libgnomeweather fork."
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=1.24.1
TERMUX_PKG_REVISION=3
TERMUX_PKG_SRCURL=https://github.com/mate-desktop/libmateweather/releases/download/v$TERMUX_PKG_VERSION/libmateweather-$TERMUX_PKG_VERSION.tar.xz
TERMUX_PKG_SHA256=9b4cfdefcd368137b9300e19fd6ed31b26a56336b78ef3fa772156755361a709
TERMUX_PKG_DEPENDS="libxml2, libsoup, gtk3"
TERMUX_PKG_RM_AFTER_INSTALL="share/glib-2.0/schemas/gschemas.compiled"
