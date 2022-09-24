TERMUX_PKG_HOMEPAGE=https://www.videolan.org/
TERMUX_PKG_DESCRIPTION="A popular libre and open source media player and multimedia engine"
TERMUX_PKG_LICENSE="GPL-2.0, LGPL-2.1"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=3.0.17.4
TERMUX_PKG_REVISION=1
#TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://download.videolan.org/pub/videolan/vlc/${TERMUX_PKG_VERSION}/vlc-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=8c5a62d88a4fb45c1b095cf10befef217dfa87aedcec5184b9e7d590b6dd4133
TERMUX_PKG_DEPENDS="avahi, chromaprint, dbus, ffmpeg, fluidsynth, fontconfig, freetype, fribidi, gdk-pixbuf, glib, gst-plugins-base, harfbuzz, liba52, libandroid-shmem, libandroid-spawn, libaom, libarchive, libass, libbluray, libc++, libcaca, libcairo, libcddb, libdav1d, libdvbpsi, libdvdread, libflac, libgcrypt, libgnutls, libiconv, libidn, libjpeg-turbo, liblua52, libmad, libnfs, libogg, libopus, libpng, librsvg, libsecret, libsoxr, libssh2, libtheora, libtwolame, libvorbis, libvpx, libx11, libx264, libx265, libxcb, libxml2, mpg123, ncurses, pulseaudio, qt5-qtbase, qt5-qtsvg, samba, taglib, zlib"
TERMUX_PKG_BUILD_DEPENDS="libebml, libmatroska, qt5-qtbase-cross-tools, xorgproto"
TERMUX_PKG_CONFLICTS="vlc"
TERMUX_PKG_REPLACES="vlc"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-static
--disable-live555
--disable-dc1394
--disable-dv1394
--disable-linsys
--disable-dvdnav
--disable-opencv
--disable-dsm
--disable-v4l2
--disable-decklink
--disable-vnc
--disable-freerdp
--disable-asdcp
--disable-gme
--disable-sid
--disable-shout
--disable-mod
--disable-mpc
--disable-shine
--disable-crystalhd
--disable-libva
--disable-dxva2
--disable-d3d11va
--disable-faad
--disable-dca
--disable-libmpeg2
--disable-speex
--disable-spatialaudio
--disable-schroedinger
--disable-mfx
--disable-fluidlite
--disable-zvbi
--disable-aribsub
--disable-aribb25
--disable-kate
--disable-tiger
--disable-vdpau
--disable-sdl-image
--disable-kva
--disable-mmal
--disable-alsa
--disable-oss
--disable-sndio
--disable-wasapi
--disable-jack
--disable-samplerate
--disable-kai
--disable-chromecast
--disable-skins2
--disable-srt
--disable-goom
--disable-projectm
--disable-vsxu
--disable-udev
--disable-mtp
--disable-upnp
--disable-microdns
--disable-notify
--disable-libplacebo
ac_cv_func_ffsll=yes
ac_cv_func_swab=yes
ac_cv_prog_LUAC=luac5.2
"

termux_step_pre_configure() {
	autoreconf -fi

	CFLAGS+=" -fcommon"
	LDFLAGS+=" -landroid-shmem -landroid-spawn -lm"
	LDFLAGS+=" -Wl,-rpath=$TERMUX_PREFIX/lib/vlc"

	local _libgcc="$($CC -print-libgcc-file-name)"
	LDFLAGS+=" -L$(dirname $_libgcc) -l:$(basename $_libgcc)"
}
