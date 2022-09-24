TERMUX_PKG_HOMEPAGE=https://www.unicorn-engine.org/
TERMUX_PKG_DESCRIPTION="Unicorn is a lightweight multi-platform, multi-architecture CPU emulator framework."
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=2.0.0
TERMUX_PKG_SRCURL=https://github.com/unicorn-engine/unicorn/archive/$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=67b445c760e2bbac663e8c8bc410e43311c7fc92df4dfa8d90e06a021d07f634
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_BREAKS="unicorn-dev"
TERMUX_PKG_REPLACES="unicorn-dev"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="-DTERMUX_ARCH=$TERMUX_ARCH"
