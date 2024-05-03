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

src_compile() {
	use print && CFLAGS="-DENABLE_PRINT ${CFLAGS}"
	use X && emake GDKTARGET=x11
	use directfb && emake GDKTARGET=directfb
}

src_install() {
	emake install PREFIX=/usr DESTDIR=${D}
}
