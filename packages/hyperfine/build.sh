TERMUX_PKG_HOMEPAGE=https://github.com/sharkdp/hyperfine
TERMUX_PKG_DESCRIPTION="A command-line benchmarking tool"
TERMUX_PKG_LICENSE="Apache-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="1.15.0"
TERMUX_PKG_SRCURL=https://github.com/sharkdp/hyperfine/archive/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=b1a7a11a1352cdb549cc098dd9caa6c231947cc4dd9cd91ec25072d6d2978172
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_post_make_install() {
	# Manpages.
	install -Dm600 doc/"${TERMUX_PKG_NAME}".1 \
		"${TERMUX_PREFIX}"/share/man/man1/"${TERMUX_PKG_NAME}".1

	# Shell completions.
	install -Dm600 target/"${CARGO_TARGET_NAME}"/release/build/"${TERMUX_PKG_NAME}"*/out/"${TERMUX_PKG_NAME}".bash \
		"${TERMUX_PREFIX}"/share/bash-completion/completions/"${TERMUX_PKG_NAME}".bash

	install -Dm600 target/"${CARGO_TARGET_NAME}"/release/build/"${TERMUX_PKG_NAME}"*/out/"${TERMUX_PKG_NAME}".fish \
		"${TERMUX_PREFIX}"/share/fish/vendor_completions.d/"${TERMUX_PKG_NAME}".fish

	install -Dm600 target/"${CARGO_TARGET_NAME}"/release/build/"${TERMUX_PKG_NAME}"*/out/_"${TERMUX_PKG_NAME}" \
		"${TERMUX_PREFIX}"/share/zsh/site-functions/_"${TERMUX_PKG_NAME}"
}
