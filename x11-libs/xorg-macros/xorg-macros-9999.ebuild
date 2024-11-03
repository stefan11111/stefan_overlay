# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="GNU autoconf macros shared across X.Org projects"
HOMEPAGE="https://gitlab.freedesktop.org/xorg/util/macros"
EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/util/macros.git"
inherit git-r3 autotools

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang )
        dev-build/autoconf
        dev-build/automake"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
    ./autogen.sh
    eautoreconf
    econf
}

src_install() {
    emake install DESTDIR=${D}
}
