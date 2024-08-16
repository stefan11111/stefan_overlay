# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="gtk2 performance analyzer"
HOMEPAGE="https://github.com/stefan11111/gtk2-perf"
EGIT_REPO_URI="https://github.com/stefan11111/gtk2-perf.git"
inherit git-r3

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang )
        x11-libs/gtk+:2
	dev-util/glib-utils
	virtual/pkgconfig"
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
    emake
    emake install PREFIX=/usr DESTDIR=${D}
}
