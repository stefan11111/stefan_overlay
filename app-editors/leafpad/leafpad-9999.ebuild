# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg git-r3 autotools

DESCRIPTION="Simple GTK2 text editor"
HOMEPAGE="http://tarot.freeshell.org/leafpad/"
#SRC_URI="mirror://nongnu/${PN}/${P}.tar.gz"
EGIT_REPO_URI="https://github.com/stefan11111/leafpad.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 ~riscv x86 ~amd64-linux ~x86-linux"
IUSE="emacs"

BDEPEND="
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig
"
DEPEND="
	virtual/libintl
	x11-libs/gtk+:2
"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		--disable-chooser \
		--disable-print \
		$(use_enable emacs)
}
