# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="kdrive X11 server"
HOMEPAGE="https://github.com/stefan11111/kdrive"
EGIT_REPO_URI="https://github.com/stefan11111/kdrive.git"
inherit git-r3 autotools

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

I_D_USE="input_devices_keyboard input_devices_mouse input_devices_evdev"

EXT_USE_1="+composite +mitshm xres record +xv xvmc dga screensaver xdmcp xdm-auth-1 +glx +dri +dri2 +dri3 +glamor"
EXT_USE_2="present xinerama xf86vidmode +xace xselinux xcsecurity tslib +dbe xf86bigfont dpms xfree86-utils libdrm +xshmfence"
EXT_USE_3="linux_acpi linux_apm"

IUSE="${I_D_USE} suid ${EXT_USE_1} ${EXT_USE_2} ${EXT_USE_3}"

REQUIRED_USE="composite? ( xace )"

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang )
        x11-libs/libXfont2
        x11-libs/libXtst
        x11-libs/libXdmcp
        x11-libs/libfontenc
	x11-libs/xorg-macros
        tslib? ( x11-libs/tslib )
        x11-base/xorg-proto
        x11-libs/xtrans
        xselinux? ( sys-process/audit
                    sys-libs/libselinux:=
                    sec-policy/selinux-xserver )
        dri3? ( media-libs/mesa[X(+),egl(+),gbm(+)] )
        dev-libs/libbsd
        glx? ( media-libs/libglvnd[X] )
        xdm-auth-1? ( x11-apps/iceauth
                      x11-apps/xauth
                      x11-libs/libXau )
        x11-apps/xkbcomp
        libdrm? ( x11-libs/libdrm )
        xdmcp? ( x11-libs/libXdmcp )
        xshmfence? ( x11-libs/libxshmfence )
        x11-libs/pixman
        x11-misc/xbitmaps
        x11-misc/xkeyboard-config"
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
    default
    eautoreconf
}

src_configure() {
    local myeconfargs=(
    --disable-selective-werror
    --with-default-font-path=/usr/share/fonts
    --with-xkb-output=/usr/var/lib/xkb
    --disable-xorg
    --enable-kdrive
    --enable-xfbdev
    --disable-clientids
    --disable-config-udev
    --disable-config-udev-kms
    --disable-config-hal
    --disable-config-wscons )

    #input
    use input_devices_keyboard && myeconfargs+=( --enable-kdrive-kbd )
    use input_devices_keyboard && ewarn "The keyboard driver is broken"
    use input_devices_keyboard && ewarn "Use the evdev driver"
    use input_devices_mouse && myeconfargs+=( --enable-kdrive-mouse )
    use input_devices_mouse && ewarn "The mouse driver has known bugs"
    use input_devices_mouse && ewarn "Use the evdev driver"
    use input_devices_evdev && myeconfargs+=( --enable-kdrive-evdev )
    use input_devices_evdev && ewarn "kdrive doesn't properly detect evdev devices"
    use input_devices_evdev && ewarn "when starting kdrive, you must do something like:"
    use input_devices_evdev && ewarn "xinit -- /usr/bin/Xfbdev :1 vt8 -mouse evdev,,device=/dev/input/eventxx -keybd evdev,,device=/dev/input/eventyy"
    use input_devices_evdev && ewarn "with xx and yy replaced with proper numbers, which can be found in /proc/bus/input/devices"
    use !input_devices_evdev && ewarn "you have disabled the only input driver that works well"
    use tslib && myeconfargs+=( --enable-tslib )

    #extensions
    use !composite && myeconfargs+=( --disable-composite )
    use !mitshm && myeconfargs+=( --disable-mitshm )
    use !xres && myeconfargs+=( --disable-xres )
    use !record && myeconfargs+=( --disable-record )
    use !xv && myeconfargs+=( --disable-xv )
    use !xvmc && myeconfargs+=( --disable-xvmc )
    use !dga && myeconfargs+=( --disable-dga )
    use !screensaver && myeconfargs+=( --disable-screensaver )
    use !xdmcp && myeconfargs+=( --disable-xdmcp )
    use !xdm-auth-1 && myeconfargs+=( --disable-xdm-auth-1 )
    use !glx &&  myeconfargs+=( --disable-glx )
    use dri && myeconfargs+=( --enable-dri )
    use dri2 && myeconfargs+=( --enable-dri2 )
    use dri3 && myeconfargs+=( --enable-dri3 )
    use glamor && myeconfargs+=( --enable-glamor )
    use !present && myeconfargs+=( --disable-present )
    use !xinerama && myeconfargs+=( --disable-xinerama )
    use !xf86vidmode && myeconfargs+=( --disable-xf86vidmode )
    use !xace && myeconfargs+=( --disable-xace )
    use xselinux && myeconfargs+=( --enable-xselinux )
    use xcsecurity && myeconfargs+=( -enable-xcsecurity )
    use !dbe && myeconfargs+=( --disable-dbe )
    use !xf86bigfont && myeconfargs+=( --disable-xf86bigfont )
    use !dpms && myeconfargs+=( --disable-dpms )
    use !libdrm && myeconfargs+=( --disable-libdrm )
    use libdrm && myeconfargs+=( --enable-libdrm )
    use !xshmfence && myecongargs+=( --disable-xshmfence )
    use !linux_acpi && myeconfargs+=( --disable-linux_acpi )
    use linux_acpi && myeconfargs+=( --enable-linux_acpi )
    use !linux_apm && myeconfargs+=( --disable-linux_apm )
    use linux_apm && myeconfargs+=( --enable-linux_apm )

    use xfree86-utils && myeconfargs+=( --enable-xfree86-utils )
    econf "${myeconfargs[@]}"
}

src_compile() {
    emake
}

src_install() {
    mkdir -p ${D}/usr/bin
    # avoid conflict with x11-base/tinyx
    cp ${S}/hw/kdrive/fbdev/Xfbdev ${D}/usr/bin/Xkdrive
    use suid && chmod 4755 ${D}/usr/bin/Xkdrive
}
