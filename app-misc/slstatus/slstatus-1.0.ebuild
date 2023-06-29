# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="suckless system status"
HOMEPAGE="https://github.com/stefan11111/slstatus"
EGIT_REPO_URI="https://github.com/stefan11111/slstatus.git"
inherit git-r3

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang )"
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=(
    "${FILESDIR}/static-dev.patch"
)

src_install() {
    emake install PREFIX=/usr DESTDIR=${D}
}
