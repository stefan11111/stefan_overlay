# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="GTK3 port of leafpad"
HOMEPAGE="https://github.com/stevenhoneyman/l3afpad"
EGIT_REPO_URI="https://github.com/stevenhoneyman/l3afpad.git"
inherit git-r3

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang )"
RDEPEND="${DEPEND}"
BDEPEND=">=x11-libs/gtk+-3"

src_install() {
	./autogen.sh
	./configure --prefix=/usr
    emake install DESTDIR=${D}
}
