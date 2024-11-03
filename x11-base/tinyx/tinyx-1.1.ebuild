# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="tinyx/kdrive X11 server"
HOMEPAGE="https://github.com/stefan11111/tinyx"
EGIT_REPO_URI="https://github.com/stefan11111/tinyx.git"
inherit git-r3

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="suid"

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang )
        x11-libs/libXfont2
        x11-libs/libXtst"
RDEPEND="${DEPEND}"
BDEPEND=""

CFLAGS="-fpermissive ${CFLAGS}"

src_configure() {
    ./autogen.sh
    econf --with-fontdir=/usr/share/fonts
}

src_install() {
    emake install DESTDIR=${D}
    use suid && chmod 4755 ${D}/usr/bin/Xfbdev
    use suid && chmod 4755 ${D}/usr/bin/Xvesa
}
