# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="tinyx/kdrive X11 server"
HOMEPAGE="https://github.com/stefan11111/tinyx https://github.com/tinycorelinux/tinyx"
EGIT_REPO_URI="https://github.com/stefan11111/tinyx.git"
#EGIT_REPO_URI=https://github.com/tinycorelinux/tinyx.git
inherit git-r3 autotools

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="libxfont2 suid xfbdev xvesa xres screensaver xdmcp xdm-auth-1 dbe xf86bigfont dpms"

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang )
        libxfont2? ( x11-libs/libXfont2 )
        !libxfont2? ( x11-libs/libXfont )
        x11-libs/libXtst
        x11-libs/libXdmcp
        x11-libs/libfontenc"
RDEPEND="${DEPEND}"
BDEPEND=""

CFLAGS="-fpermissive ${CFLAGS}"

#src_unpack() {
#    local -x EGIT_REPO_URI
#    if use libxfont2; then
#        EGIT_REPO_URI=https://github.com/stefan11111/tinyx.git
#    else
#        EGIT_REPO_URI=https://github.com/tinycorelinux/tinyx.git
#    fi
#    git-r3_src_unpack
#}

src_prepare() {
    default
    eautoreconf
}

src_configure() {
    local myeconfargs=( --with-fontdir=/usr/share/fonts )
    use !xfbdev && myeconfargs+=( --disable-xfbdev )
    use !xvesa && myeconfargs+=( --disable-xvesa )
    use !xres && myeconfargs+=( --disable-xres )
    use !screensaver && myeconfargs+=( --disable-screensaver )
    use !xdmcp && myeconfargs+=( --disable-xdmcp )
    use !xdm-auth-1 && myeconfargs+=( --disable-xdm-auth-1 )
    use !dbe && myeconfargs+=( --disable-dbe )
    use !xf86bigfont && myeconfargs+=( --disable-xf86bigfont )
    use !dpms && myeconfargs+=( --disable-dpms )
    use libxfont2 && myeconfargs+=( --enable-libXfont2 )
    econf "${myeconfargs[@]}"
}

src_install() {
    emake install DESTDIR=${D}
    use suid && use xfbdev && chmod 4755 ${D}/usr/bin/Xfbdev
    use suid && use xvesa && chmod 4755 ${D}/usr/bin/Xvesa
    use xvesa && ewarn "Xvesa doesn't work with a 64-bit kernel on amd64"
    use !xvesa && use !xfbdev && ewarn "You have disabled both X servers. This is a useless configuration"
    use !libxfont2 && ewarn "You have built tinyx with libXfont1. The default in ::gentoo is libXfont2, which is also used by Xorg"
    use !libxfont2 && ewarn "Unless you have configured your system to use libXfont1 instead of libXfont2, tinyx will not work"
}
