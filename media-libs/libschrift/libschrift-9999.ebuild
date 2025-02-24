# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="A lightweight TrueType font rendering library"
HOMEPAGE="https://github.com/tomolt/libschrift"
EGIT_REPO_URI="https://github.com/tomolt/libschrift.git"
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
