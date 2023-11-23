# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="libcrypto compatibility library"
HOMEPAGE="https://github.com/stefan11111/libcrypto-compat"
EGIT_REPO_URI="https://github.com/stefan11111/libcrypto-compat.git"
inherit git-r3

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="patchelf"

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang )"
RDEPEND="${DEPEND}
	patchelf? ( dev-util/patchelf )"
BDEPEND=""

src_install() {
    emake install PREFIX=/usr DESTDIR=${D}
} 
