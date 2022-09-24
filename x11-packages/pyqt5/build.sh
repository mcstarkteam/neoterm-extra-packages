TERMUX_PKG_HOMEPAGE=https://www.riverbankcomputing.com/software/pyqt/
TERMUX_PKG_DESCRIPTION="Comprehensive Python Bindings for Qt v5"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=5.15.6
TERMUX_PKG_SRCURL=https://ftp-osl.osuosl.org/pub/gentoo/distfiles/PyQt5-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=80343bcab95ffba619f2ed2467fd828ffeb0a251ad7225be5fc06dcc333af452
TERMUX_PKG_DEPENDS="python, qt5-qtbase, qt5-qtdeclarative, qt5-qtlocation, qt5-qtmultimedia, qt5-qtsensors, qt5-qtsvg, qt5-qttools, qt5-qtwebchannel, qt5-qtwebkit, qt5-qtwebsockets, qt5-qtx11extras, qt5-qtxmlpatterns"
TERMUX_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools, qt5-qtdeclarative-cross-tools, qt5-qttools-cross-tools"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_EXTRA_MAKE_ARGS="
--verbose
--scripts-dir=$TERMUX_PREFIX/bin
--confirm-license
--qmake=$TERMUX_PREFIX/opt/qt/cross/bin/qmake
"

# ```
# /home/builder/.termux-build/pyqt5/src/sip/QtQuick/qsggeometry.sip:136:30:
# error: use of undeclared identifier 'GL_BYTE'
#			 case GL_BYTE:
#			      ^
# /home/builder/.termux-build/pyqt5/src/sip/QtQuick/qsggeometry.sip:148:30:
# error: use of undeclared identifier 'GL_FLOAT'
#			 case GL_FLOAT:
#			      ^
# /home/builder/.termux-build/pyqt5/src/sip/QtQuick/qsggeometry.sip:152:30:
# error: use of undeclared identifier 'GL_INT'
#			 case GL_INT:
#			      ^
# 3 errors generated.
# ```
TERMUX_PKG_EXTRA_MAKE_ARGS+=" --disable=QtQuick"

termux_step_pre_configure() {
	_PYTHON_VERSION=$(. $TERMUX_SCRIPTDIR/packages/python/build.sh; echo $_MAJOR_VERSION)
	termux_setup_python_crossenv
	pushd $TERMUX_PYTHON_CROSSENV_SRCDIR
	_CROSSENV_PREFIX=$TERMUX_PKG_BUILDDIR/python-crossenv-prefix
	python${_PYTHON_VERSION} -m crossenv \
		$TERMUX_PREFIX/bin/python${_PYTHON_VERSION} \
		${_CROSSENV_PREFIX}
	popd
	. ${_CROSSENV_PREFIX}/bin/activate

	build-pip install PyQt-builder

	local _cxx=$(basename $CXX)
	local _bindir=$TERMUX_PKG_BUILDDIR/_wrapper/bin
	mkdir -p ${_bindir}
	sed -e 's|@CXX@|'"$(command -v $CXX)"'|g' \
		-e 's|@TERMUX_PREFIX@|'"${TERMUX_PREFIX}"'|g' \
		-e 's|@PYTHON_VERSION@|'"${_PYTHON_VERSION}"'|g' \
		$TERMUX_PKG_BUILDER_DIR/cxx-wrapper > ${_bindir}/${_cxx}
	chmod 0700 ${_bindir}/${_cxx}
	export PATH=${_bindir}:$PATH

	TERMUX_PKG_EXTRA_MAKE_ARGS+=" --target-dir=$TERMUX_PREFIX/lib/python${_PYTHON_VERSION}/site-packages"
}

termux_step_make() {
	python ${_CROSSENV_PREFIX}/build/bin/sip-build \
		--jobs ${TERMUX_MAKE_PROCESSES} \
		${TERMUX_PKG_EXTRA_MAKE_ARGS}
}

termux_step_make_install() {
	make -C build install

	local f
	for f in pylupdate5 pyrcc5 pyuic5; do
		local t="$TERMUX_PREFIX/bin/${f}"
		rm -f "${t}"
		sed -e 's|@TERMUX_PREFIX@|'"${TERMUX_PREFIX}"'|g' \
			"$TERMUX_PKG_BUILDER_DIR/${f}.in" > "${t}"
		chmod 0700 "${t}"
	done
}

termux_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$TERMUX_PREFIX/bin/sh
	echo "Installing dependencies through pip..."
	pip3 install PyQt5-sip
	EOF
}
