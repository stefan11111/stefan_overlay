# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8
DESCRIPTION="Header needed to build xorg without mesa"
HOMEPAGE="https://github.com/stefan11111/dri_interface.h"
EGIT_REPO_URI="https://github.com/stefan11111/dri_interface.h.git"
inherit git-r3

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="abi_x86_64 abi_x86_32"

DEPEND=""
RDEPEND=""
BDEPEND=""

src_install() {
    if use abi_x86_64; then
        emake install DESTDIR=${D}
    fi

    if use abi_x86_32; then
        emake install DESTDIR=${D} LIBDIR=/usr/lib
    fi
}
