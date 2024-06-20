# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="The Not Too Bad TLS Library"
HOMEPAGE="https://gnupg.org/software/ntbtls/index.html"
EGIT_REPO_URI="git://git.gnupg.org/ntbtls.git"
inherit git-r3

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang )
        >=dev-libs/libgpg-error-1.25
        >=dev-libs/libgcrypt-1.8.0
        >=dev-libs/libksba-1.2.0"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
    ./autogen.sh
    econf
}

src_install() {
    emake install PREFIX=/usr DESTDIR=${D}
}
