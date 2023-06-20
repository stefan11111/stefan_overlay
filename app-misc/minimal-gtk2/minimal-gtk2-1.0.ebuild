# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="A patch for gtk2"
HOMEPAGE="https://github.com/stefan11111/minimal-gtk2"
EGIT_REPO_URI="https://github.com/stefan11111/minimal-gtk2.git"
inherit git-r3

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
    emake install PREFIX=/usr DESTDIR=${D}
} 
