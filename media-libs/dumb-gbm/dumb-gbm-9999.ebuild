# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="libgbm backend for allocating dumb buffers"
HOMEPAGE="https://github.com/stefan11111/dumb_gbm"
EGIT_REPO_URI="https://github.com/stefan11111/dumb_gbm.git"
inherit git-r3 multilib-minimal

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="abi_x86_32 abi_x86_64 strict"

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang )
                x11-libs/libdrm
                virtual/pkgconfig"
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
    if use abi_x86_64; then
        if use strict; then
            emake install PREFIX=/usr DESTDIR=${D} STRICT=1
        else
            emake install PREFIX=/usr DESTDIR=${D}
        fi
    fi
    if use abi_x86_32; then
        emake clean
        if use strict; then
            emake install PREFIX=/usr DESTDIR=${D} LIBDIR=/lib CFLAGS="${CFLAGS} -m32" STRICT=1
        else
            emake install PREFIX=/usr DESTDIR=${D} LIBDIR=/lib CFLAGS="${CFLAGS} -m32"
        fi
    fi
}
