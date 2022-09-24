TERMUX_PKG_HOMEPAGE=https://gstreamer.freedesktop.org/
TERMUX_PKG_DESCRIPTION="Open source multimedia framework"
TERMUX_PKG_LICENSE="LGPL-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=1.20.3
TERMUX_PKG_SRCURL=https://gstreamer.freedesktop.org/src/gstreamer/gstreamer-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=607daf64bbbd5fb18af9d17e21c0d22c4d702fffe83b23cb22d1b1af2ca23a2a
TERMUX_PKG_DEPENDS="glib"
TERMUX_PKG_BREAKS="gstreamer-dev"
TERMUX_PKG_REPLACES="gstreamer-dev"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-Dcheck=disabled
-Dtests=disabled
-Dexamples=disabled
-Dbenchmarks=disabled
-Dlibunwind=disabled
-Dlibdw=disabled
"
