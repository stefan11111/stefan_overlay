# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="DirectfFB gfxdriver for nvidia cards"
HOMEPAGE="https://github.com/stefan11111/DirectFB-nvidia"
EGIT_REPO_URI="https://github.com/stefan11111/DirectFB-nvidia.git"
inherit git-r3 multilib-minimal

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang )
        virtual/directfb[${MULTILIB_USEDEP}]
        "
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
    use abi_x86_32 && CFLAGS="${CFLAGS} -m32"
}

src_compile() {
    emake
}

src_install() {
    if use abi_x86_64; then
        emake install PREFIX=/usr DESTDIR=${D}
    fi
    if use abi_x86_32; then
        emake clean
        emake install PREFIX=/usr DESTDIR=${D} LIBDIR=/lib
    fi
}
