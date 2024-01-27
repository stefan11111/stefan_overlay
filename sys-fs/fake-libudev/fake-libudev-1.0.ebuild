# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="Dummy implementation of libudev"
HOMEPAGE="https://github.com/stefan11111/fake-libudev"
EGIT_REPO_URI="https://github.com/stefan11111/fake-libudev.git"
inherit git-r3

CFLAGS="${CFLAGS}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="abi_x86_32 abi_x86_64"

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang )"
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	if abi_x86_64; then
		emake install PREFIX=/usr DESTDIR=${D} LIBDIR=/lib64
	fi
	if use abi_x86_32; then
		emake clean
		emake install PREFIX=/usr DESTDIR=${D} LIBDIR=/lib CFLAGS="${CFLAGS} -m32"
	fi
}
