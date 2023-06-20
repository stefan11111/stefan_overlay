# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="Minimal fetch written in c"
HOMEPAGE="https://github.com/stefan11111/cfetch"
EGIT_REPO_URI="https://github.com/stefan11111/cfetch.git"
inherit git-r3

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang )"
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
    emake install PREFIX=/usr DESTDIR=${D}
}
