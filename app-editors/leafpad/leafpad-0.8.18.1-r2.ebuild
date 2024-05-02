# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg git-r3

DESCRIPTION="Simple GTK2 text editor"
HOMEPAGE="https://github.com/stefan11111/leafpad"
SRC_URI="https://github.com/stefan11111/leafpad/archive/refs/tags/0.8.18.1-r2.tar.gz"

CFLAGS="-Wall -Wextra -Werror ${CFLAGS}"

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

src_configure() {
	econf \
		--disable-chooser \
		--disable-print \
		$(use_enable emacs)
}
