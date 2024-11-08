# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="tinyx/kdrive X11 server"
HOMEPAGE="https://github.com/stefan11111/tinyx https://github.com/tinycorelinux/tinyx"
#EGIT_REPO_URI="https://github.com/stefan11111/tinyx.git"
inherit git-r3 autotools

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="libxfont2 suid"

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang )
        libxfont2? ( x11-libs/libXfont2 )
        !libxfont2? ( x11-libs/libXfont )
        x11-libs/libXtst"
RDEPEND="${DEPEND}"
BDEPEND=""

CFLAGS="-fpermissive ${CFLAGS}"

src_unpack() {
    local EGIT_REPO_URI
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
    econf --with-fontdir=/usr/share/fonts
}

src_install() {
    emake install DESTDIR=${D}
    use suid && chmod 4755 ${D}/usr/bin/Xfbdev
    use suid && chmod 4755 ${D}/usr/bin/Xvesa
}
