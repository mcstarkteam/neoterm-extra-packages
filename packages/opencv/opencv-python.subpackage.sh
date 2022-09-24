TERMUX_SUBPKG_INCLUDE="lib/python*"
TERMUX_SUBPKG_DESCRIPTION="Python bindings for OpenCV"
TERMUX_SUBPKG_DEPENDS="python"

termux_step_create_subpkg_debscripts() {
	echo "#!$TERMUX_PREFIX/bin/sh" > postinst
	echo "MATHLIB=m pip3 install numpy==1.23.3" >> postinst
}
