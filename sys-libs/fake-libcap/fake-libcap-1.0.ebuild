# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="https://github.com/stefan11111/fake-libcap.git"
HOMEPAGE="https://github.com/stefan11111/fake-libcap"
EGIT_REPO_URI="https://github.com/stefan11111/fake-libcap.git"
inherit git-r3

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="abi_x86_32 abi_x86_64"

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang )
        "
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
    if use abi_x86_64; then
        emake install PREFIX=/usr DESTDIR=${D}
    fi
    if use abi_x86_32; then
        emake clean
        emake install PREFIX=/usr DESTDIR=${D} LIBDIR=/lib CFLAGS="${CFLAGS} -m32"
    fi
}
