# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="kdrive X11 server"
HOMEPAGE="https://github.com/stefan11111/kdrive"
EGIT_REPO_URI="https://github.com/stefan11111/kdrive.git"
inherit git-r3 autotools linux-info

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
	x11-misc/util-macros
        tslib? ( x11-libs/tslib )
        x11-base/xorg-proto
        x11-libs/xtrans
        xselinux? ( sys-process/audit
                    sys-libs/libselinux:=
                    sec-policy/selinux-xserver )
        || ( x11-base/xorg-dri-interface media-libs/mesa[X(+),egl(+),gbm(+)] )
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

pkg_pretend() {
    if use input_devices_evdev ; then
        CONFIG_CHECK="~INPUT_EVDEV"
    fi
    check_extra_config
}

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
    use input_devices_keyboard && ewarn "Enabling the keyboard driver disables threaded input, even for evdev"
    use !input_devices_keyboard && myeconfargs+=( --disable-kdrive-kbd )

    use input_devices_mouse && myeconfargs+=( --enable-kdrive-mouse )
    use !input_devices_mouse && myeconfargs+=( --disable-kdrive-mouse )

    use input_devices_evdev && myeconfargs+=( --enable-kdrive-evdev )
    use !input_devices_evdev && myeconfargs+=( --disable-kdrive-evdev )

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

    einfo "The kdrive X server has a few quirks in regards to input drivers"
    einfo "If you enabled the keyboard and mouse drivers, starting kdrive normally should work fine"
    einfo "You should be able to just do 'xinit -- /usr/bin/Xkdrive', or however you start X"
    einfo "The evdev driver doesn't work out of the box."
    einfo "You have to pass evdev devices as command line arguments."
    einfo "Like so: 'xinit -- /usr/bin/Xkdrive -mouse evdev,,device=/dev/input/eventxx -keybd,,device=/dev/input/eventyy'"
    einfo "Where eventxx and eventyy are replaced with the proper evdev devices"
    einfo "You can also mix evdev, keyboard and mouse drivers however you like"
    einfo "You might want to emerge x11-apps/start-kdrive, which attempts to detect the proper evdev devices"
    einfo "The mouse driver also comes with separate ps2 and ms drivers"
    einfo "you can use those by passing '-mouse ps2' or '-mouse ms' to the Xkdrive command line"
    einfo "There are also different mouse protocols you can explicitly tell the mouse driver to use"
    einfo "You can enable the by passing '-mouse mouse,,protocol=<protocol>' to kdrive"
    einfo "To see the full list of protocols, just pass something random as the protocol and kdrive will tell you the full list"
}
