# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="DirectFB wrapper for Linux Framebuffer applications"
HOMEPAGE="https://github.com/caramelli/DirectFB-fbdev"
EGIT_REPO_URI="https://github.com/caramelli/DirectFB-fbdev.git"
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

src_prepare() {
    default
    eautoreconf
}

src_configure() {
    econf
}

src_install() {
    emake install DESTDIR=${D}
}
