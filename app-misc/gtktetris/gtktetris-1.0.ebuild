# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Simple GTK tetris game"
HOMEPAGE="https://github.com/wader/gtktetris"
#SRC_URI="https://github.com/wader/gtktetris/archive/refs/tags/1.0.tar.gz"
EGIT_REPO_URI="https://github.com/wader/gtktetris.git"

CFLAGS="${CFLAGS} -fcommon"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 ~riscv x86 ~amd64-linux ~x86-linux"
IUSE="gtk2 gtk3"
REQUIRED_USE="^^ ( gtk2 gtk3 )"
BDEPEND="
	virtual/pkgconfig
"
DEPEND="
	gtk2? ( x11-libs/gtk+:2 )
	gtk3? ( x11-libs/gtk+:3 )
"
RDEPEND="${DEPEND}"

src_configure() {
	econf $(use_enable gtk2)
}
