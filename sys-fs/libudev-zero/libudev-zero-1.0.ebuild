# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="Daemonless replacement for libudev"
HOMEPAGE="https://github.com/illiliti/libudev-zero"
EGIT_REPO_URI="https://github.com/illiliti/libudev-zero.git"
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
	if use abi_x86_64; then
		emake install-shared PREFIX=/usr DESTDIR=${D} LIBDIR=/lib64 PKGCONFIGDIR=/usr/lib64/pkgconfig
	fi
	if use abi_x86_32; then
		emake clean
		emake install-shared PREFIX=/usr DESTDIR=${D} LIBDIR=/lib PKGCONFIGDIR=/usr/lib64/pkgconfig CFLAGS="${CFLAGS} -m32"
	fi
}
