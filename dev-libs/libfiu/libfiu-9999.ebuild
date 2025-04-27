# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="A C library for fault injection"
HOMEPAGE="https://github.com/albertito/libfiu"
EGIT_REPO_URI="https://github.com/albertito/libfiu.git"
inherit git-r3

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="python"

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang )"
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() {
    emake
    use python && emake python3
}

src_install() {
    emake install PREFIX=/usr DESTDIR=${D}
    use python && emake python3_install PREFIX=/usr DESTDIR=${D}
}
