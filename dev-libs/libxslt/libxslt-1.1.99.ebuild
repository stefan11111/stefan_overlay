# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="dummy libxslt implementation "
HOMEPAGE="https://github.com/stefan11111/fake-libxslt"
EGIT_REPO_URI="https://github.com/stefan11111/fake-libxslt.git"
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
		emake install PREFIX=/usr DESTDIR=${D} LIBDIR=/usr/lib64 PKGCONF_LIBDIR=/lib64
	fi
	if use abi_x86_32; then
		emake clean
		emake install PREFIX=/usr DESTDIR=${D} LIBDIR=/usr/lib PKGCONF_LIBDIR=/lib64 CFLAGS="${CFLAGS} -m32"
	fi
}
