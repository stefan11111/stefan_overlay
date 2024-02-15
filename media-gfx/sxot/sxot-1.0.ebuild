# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="Simple X11 Screenshot tool."
HOMEPAGE="https://codeberg.org/NRK/sxot"
EGIT_REPO_URI="https://codeberg.org/NRK/sxot.git"
inherit git-r3

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang )
	x11-base/xorg-server
	x11-libs/libX11
	x11-libs/libXfixes
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	cc -o sxot sxot.c ${CFLAGS} -l X11 -l Xfixes
	mkdir -p ${D}/usr/bin
	cp sxot ${D}/usr/bin
}
