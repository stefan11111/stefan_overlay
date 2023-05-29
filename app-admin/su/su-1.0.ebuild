# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="Su implementation without pam"
HOMEPAGE="https://github.com/stefan11111/su"
EGIT_REPO_URI="https://github.com/stefan11111/su	.git"
inherit git-r3

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang ) virtual/libcrypt"
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
    emake install PREFIX=/usr DESTDIR=${D}
} 
