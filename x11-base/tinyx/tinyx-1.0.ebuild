# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="tinyx/kdrive X11 server"
HOMEPAGE="https://github.com/stefan11111/tinyx https://github.com/tinycorelinux/tinyx"
#EGIT_REPO_URI="https://github.com/stefan11111/tinyx.git"
EGIT_REPO_URI=https://github.com/tinycorelinux/tinyx.git
inherit git-r3 autotools

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="libxfont2 suid xfbdev xvesa"

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

src_unpack() {
    local -x EGIT_REPO_URI
    if use libxfont2; then
        EGIT_REPO_URI=https://github.com/stefan11111/tinyx.git
    else
        EGIT_REPO_URI=https://github.com/tinycorelinux/tinyx.git
    fi
    git-r3_src_unpack
}

src_prepare() {
    default
    eautoreconf
}

src_configure() {
    local myeconfargs=( --with-fontdir=/usr/share/fonts )
    use !xfbdev && myeconfargs+=( --disable-xfbdev )
    use !xvesa && myeconfargs+=( --disable-xvesa )
    econf "${myeconfargs[@]}"
}

src_install() {
    emake install DESTDIR=${D}
    use suid && use xfbdev && chmod 4755 ${D}/usr/bin/Xfbdev
    use suid && use xvesa && chmod 4755 ${D}/usr/bin/Xvesa
    use xvesa && ewarn "Xvesa doesn't work with a 64-bit kernel on amd64"
    use !xvesa && use !xfbdev && ewarn "You disabled both X servers. This is a useless configuration"
}
