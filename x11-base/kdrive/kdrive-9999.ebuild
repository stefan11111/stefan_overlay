# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic xorg-meson
EGIT_REPO_URI="https://github.com/stefan11111/kdrive.git"

DESCRIPTION="X.Org X servers"
SLOT="0/${PV}"

KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~loong ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"

IUSE_SERVERS="xephyr xfbdev xvfb"
IUSE_EXTENSIONS="+xdmcp +xdm-auth-1 +dpms xf86bigfont +screensaver +xres +xace xcsecurity +xinerama +xv +xvmc +dga +mitshm +agp +dri1 +dri2 +dri3"
IUSE_OTHER="debug +drm +elogind +gbm +glx +glx-dri +ipv6 linux_apm linux_acpi minimal selinux suid systemd test +udev unwind"
IUSE="${IUSE_SERVERS} ${IUSE_EXTENSIONS} ${IUSE_OTHER}"
RESTRICT="!test? ( test )"

CDEPEND="
	media-libs/libglvnd[X]
	dev-libs/libbsd
	dev-libs/openssl:0=
	>=x11-apps/iceauth-1.0.2
	>=x11-apps/xauth-1.0.3
	x11-apps/xkbcomp
	>=x11-libs/libdrm-2.4.89
	>=x11-libs/libpciaccess-0.12.901
	>=x11-libs/libXau-1.0.4
	>=x11-libs/libXdmcp-1.0.2
	>=x11-libs/libXfont2-2.0.1
	>=x11-libs/libxkbfile-1.0.4
	>=x11-libs/libxshmfence-1.1
	>=x11-libs/pixman-0.27.2
	>=x11-misc/xbitmaps-1.0.1
	>=x11-misc/xkeyboard-config-2.4.1-r3
	xephyr? (
		x11-libs/libxcb
		x11-libs/xcb-util
		x11-libs/xcb-util-image
		x11-libs/xcb-util-keysyms
		x11-libs/xcb-util-renderutil
		x11-libs/xcb-util-wm
	)
	!minimal? (
		>=media-libs/mesa-18[X(+),egl(+),gbm(+)]
		>=media-libs/libepoxy-1.5.4[X,egl(+)]
	)
	udev? ( virtual/libudev:= )
	unwind? ( sys-libs/libunwind:= )
	selinux? (
		sys-process/audit
		sys-libs/libselinux:=
	)
	systemd? (
		sys-apps/dbus
		sys-apps/systemd
	)
	elogind? (
		sys-apps/dbus
		sys-auth/elogind[pam]
		sys-auth/pambase[elogind]
	)
	!!x11-drivers/nvidia-drivers[-libglvnd(+)]
"
DEPEND="${CDEPEND}
	>=x11-base/xorg-proto-2024.1
	>=x11-libs/xtrans-1.3.5
	media-fonts/font-util
	test? ( >=x11-libs/libxcvt-0.1.0 )
"
RDEPEND="${CDEPEND}
	!systemd? ( gui-libs/display-manager-init )
	selinux? ( sec-policy/selinux-xserver )
	>=x11-apps/xinit-1.3.3-r1
"
BDEPEND="
	app-alternatives/lex
"
PDEPEND=""

REQUIRED_USE="!minimal? (
		|| ( ${IUSE_SERVERS} )
	)
	elogind? ( udev )
	?? ( elogind systemd )"

src_configure() {
	# bug #835653
	use x86 && replace-flags -Os -O2
	use x86 && replace-flags -Oz -O2

	use debug && EMESON_BUILDTYPE=debug

	# localstatedir is used for the log location; we need to override the default
	#	from ebuild.sh
	# sysconfdir is used for the xorg.conf location; same applies
	local XORG_CONFIGURE_OPTIONS=(
		--localstatedir "${EPREFIX}/var"
		--sysconfdir "${EPREFIX}/etc/X11"
		-Db_ndebug=$(usex debug false true)
		$(meson_use agp)
		$(meson_use dga)
		$(meson_use dri1)
		$(meson_use dri2)
		$(meson_use dri3)
		$(meson_use drm)
		$(meson_use dpms)
		$(meson_use !minimal glamor)
		$(meson_use gbm)
		$(meson_use glx)
		$(meson_use glx-dri glx_dri)
		$(meson_use ipv6)
                $(meson_use linux_acpi)
		$(meson_use linux_apm)
		$(meson_use mitshm)
		$(meson_use screensaver)
		$(meson_use udev)
		$(meson_use udev udev_kms)
		$(meson_use unwind libunwind)
		$(meson_use xcsecurity)
		$(meson_use selinux xselinux)
		$(meson_use xace)
		$(meson_use xdmcp)
		$(meson_use xdm-auth-1)
		$(meson_use xephyr)
		$(meson_use xf86bigfont)
		$(meson_use xfbdev)
		$(meson_use xinerama)
		$(meson_use xres)
		$(meson_use xv)
		$(meson_use xvmc)
		$(meson_use xvfb)
		$(meson_use test tests)
		$(meson_use test xf86-input-inputtest)
		-Ddocs=false
		-Ddtrace=false
		-Dhal=false
		-Dsha1=libcrypto
		-Dxkb_output_dir="${EPREFIX}/var/lib/xkb"
		-Dxnest=false
		-Dxorg=false
	)

	if [[ ${PV} == 9999 ]] ; then
		# Gone in 21.1.x, but not in master.
		XORG_CONFIGURE_OPTIONS+=( -Dxwayland=false )
	fi

	if use systemd || use elogind; then
		XORG_CONFIGURE_OPTIONS+=(
			-Dsystemd_logind=true
			$(meson_use suid suid_wrapper)
		)
	else
		XORG_CONFIGURE_OPTIONS+=(
			-Dsystemd_logind=false
			-Dsuid_wrapper=false
		)
	fi

	xorg-meson_src_configure
}

src_install() {
	xorg-meson_src_install

	# Xfbdev should always be installed suid
	if use xfbdev; then
		chmod 4755 "${ED}"/usr/bin/Xfbdev
	fi

	rm -f "${ED}"/usr/share/man/man1/Xserver.1x \
		"${ED}"/usr/$(get_libdir)/xserver/SecurityPolicy \
		"${ED}"/usr/$(get_libdir)/pkgconfig/xorg-server.pc \
		"${ED}"/usr/share/man/man1/Xserver.1x || die
}
