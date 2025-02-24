# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="Terminal irc client"
HOMEPAGE="https://github.com/mcpcpc/kirc"
SRC_URI="https://github.com/mcpcpc/kirc/archive/refs/tags/0.3.3.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang )"
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
    emake install PREFIX=/usr DESTDIR=${D}
}
