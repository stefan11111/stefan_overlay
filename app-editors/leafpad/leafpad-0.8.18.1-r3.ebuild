# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="Simple GTK2 text editor"
HOMEPAGE="https://github.com/stefan11111/leafpad"
EGIT_REPO_URI="https://github.com/stefan11111/leafpad.git"
inherit git-r3

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="|| (    sys-devel/gcc
                sys-devel/clang )
	x11-libs/gtk+:2"
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	emake install PREFIX=/usr DESTDIR=${D}
}
