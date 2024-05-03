# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="Simple GTK2 text editor"
HOMEPAGE="https://github.com/stefan11111/leafpad"
EGIT_REPO_URI="https://github.com/stefan11111/leafpad.git"
inherit git-r3

IUSE="print X directfb"

REQUIRED_USE="^^ ( X directfb )"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang )
	X? ( x11-libs/gtk+:2[X] )
	directfb? ( x11-libs/gtk+:2[directfb] )"
RDEPEND="${DEPEND}"
BDEPEND=""

use print && CFLAGS="${CFLAGS} -DENABLE_PRINT"

src_install() {
	if use X; then
		emake install PREFIX=/usr DESTDIR=${D} GDKTARGET=x11
	fi
	if use directfb; then
		emake install PREFIX=/usr DESTDIR=${D} GDKTARGET=directfb
	fi
}
