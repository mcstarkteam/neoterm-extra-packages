TERMUX_PKG_HOMEPAGE=https://github.com/hashicorp/hcl
TERMUX_PKG_DESCRIPTION="A toolkit for creating structured configuration languages"
TERMUX_PKG_LICENSE="MPL-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="2.14.0"
TERMUX_PKG_SRCURL=https://github.com/hashicorp/hcl/archive/refs/tags/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=9551187db8d5a399130149349afb5ccecd7b795fea4a3d0c0c5628d6faf0017a
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_AUTO_UPDATE=true

_HCL_TOOLS="hcldec hclfmt hclspecsuite"

termux_step_pre_configure() {
	termux_setup_golang
	export GOPATH=$TERMUX_PKG_BUILDDIR/_go
	mkdir -p $GOPATH
	go mod tidy
}

termux_step_make() {
	for f in $_HCL_TOOLS; do
		go install ./cmd/$f
	done
}

termux_step_make_install() {
	for f in $_HCL_TOOLS; do
		install -Dm700 -t $TERMUX_PREFIX/bin $GOPATH/bin/*/$f
	done
}
